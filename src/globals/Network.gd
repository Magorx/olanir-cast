extends Node


const DEFAULT_PORT = 10005
const MAX_CLIENTS = 10


var server = null
var client = null


var tickrate_timer: Timer = null


var unique_runtime_suffix_cnt = 1


class SharedNode extends Node:
    var scene_path: String
    var node: Node
    var suffix: String
    var network_id: int
    var parent_path: String
    var setup_args: Dictionary
    
    var shared: bool = false

    func _init(scene_path_, parent: Node = null, setup_args_: Dictionary = {}):
        scene_path = scene_path_
        suffix = Network.unique_suffix()
        parent_path = parent.get_path()
        network_id = Network.get_id()
        setup_args = setup_args_

        node = Network.unique_instance(scene_path, suffix, network_id, parent_path, setup_args)
    
    func share():
        if shared:
            printerr("Tried to share object [", self, "], but it is already shared")
            return
        
        if node.has_method("get_setup_args"):
            setup_args = node.get_setup_args()

        shared = true
        Network.rpc("unique_instance", scene_path, suffix, network_id, parent_path, setup_args)
#        Network.get_tree().root.get_node(parent_path).add_child(node)
        if "shared" in node:
            node.shared = true


func get_id():
    return get_tree().get_network_unique_id()


func unique_suffix():
    var ret = str(get_tree().get_network_unique_id()) + str(unique_runtime_suffix_cnt)
    unique_runtime_suffix_cnt += 1
    return ret


func shared_unique_instance(pk_obj, parent: Node = null, setup_args: Dictionary = {}):
    var suffix = unique_suffix()
    var parent_path = parent.get_path()
    var master_id = get_tree().get_network_unique_id()

    rpc("unique_instance", pk_obj, suffix, master_id, parent_path, setup_args)
    return unique_instance(pk_obj, suffix, master_id, parent_path, setup_args)


remote func unique_instance(pk_obj, suffix, id, parent_path=null, setup_args: Dictionary = {}):
    var obj = load(pk_obj).instance()
    obj.name += suffix
    obj.set_network_master(id)
    
    if parent_path:
        get_tree().root.get_node(parent_path).add_child(obj)

    if setup_args:
        obj.setup(setup_args)
    
    return obj


func _ready():
    var __ = null
    __ = get_tree().connect("connected_to_server", self, "_connected_to_server")
    __ = get_tree().connect("server_disconnected", self, "_server_disconnected")
    __ = get_tree().connect("connection_failed", self, "_connection_failed")
    
    __ = get_tree().connect("network_peer_connected", self, "_network_peer_connected")
    __ = get_tree().connect("network_peer_disconnected", self, "_network_peer_disconnected")
    
    tickrate_timer = Timer.new()
    tickrate_timer.wait_time = 0.03
    add_child(tickrate_timer)
    tickrate_timer.start()


func create_server(port=null):
    if not port:
        port = DEFAULT_PORT


    server = NetworkedMultiplayerENet.new()
    server.create_server(port, MAX_CLIENTS)
    get_tree().set_network_peer(server)


func join_server(ip, port=null):
    if not port:
        port = DEFAULT_PORT        

    client = NetworkedMultiplayerENet.new()
    client.create_client(ip, port)
    get_tree().set_network_peer(client)


func _connected_to_server():
    print("Connected to the server")


func _server_disconnected():
    print("Disconnected from the server")
    
    Game.unload_current_level()


func _connection_failed():
    print("Connection failed")


func _network_peer_connected(id):
    print("Peer [" + str(id) + "] connected")
    
    if get_tree().is_network_server():
        register_player(id)
        return

    yield(Game, "level_loaded")
    var _player = instance_player(id)

    Game.set_local_player(Network.instance_player(get_tree().get_network_unique_id()))


func register_player(id):
    rpc_id(id, "load_level", Game.get_current_level().in_game_name)
    var __ = instance_player(id)


func _network_peer_disconnected(id):
    print("Peer [" + str(id) + "] disconnected")


func instance_player(id) -> Creature:
    var level = Game.get_current_level()
    
    var creature = GameInfo.CREATURES["wizard"].instance()
    creature.name += str(id)

    var player = level.add_creature(creature, 1)
#    var player = level.add_creature(creature, GameInfo.TEAM_AUTOCHOICE)
    player.set_network_master(id)
    player.shared = true
    
    return player


remote func load_level(name):
    Game.load_level(name)
