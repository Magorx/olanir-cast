extends Node


signal level_loaded


var AVAILABLE_LIGHTNING_Z_INDEX = []

var current_level: Level = null
var current_controller: Controller = null
var local_player = null


var pk_wizard = preload("res://wizard.tscn")


func _ready():
    for i in range(GameInfo.MIN_LIGHTNING_Z_INDEX, GameInfo.MAX_LIGHTNING_Z_INDEX):
        AVAILABLE_LIGHTNING_Z_INDEX.append(i)
    
    current_controller = load("res://utils/controller/Controller.tscn").instance()
    add_child(current_controller)


func get_lightning_z_index():
    if not AVAILABLE_LIGHTNING_Z_INDEX.size():
        return 0
    
    var idx = AVAILABLE_LIGHTNING_Z_INDEX.back()
    AVAILABLE_LIGHTNING_Z_INDEX.pop_back()
    
    return idx


func release_lightning_z_index(idx):
    if idx < GameInfo.MIN_LIGHTNING_Z_INDEX or idx > GameInfo.MAX_LIGHTNING_Z_INDEX:
        return
    
    AVAILABLE_LIGHTNING_Z_INDEX.append(idx)


func get_current_level() -> Level:
    return current_level


func load_level(name, to_add_extension=true):
    name = "res://collection/levels/" + name
    if to_add_extension:
        name += GameInfo.LEVEL_EXTENSION

    var pk_level = load(name)
    var __ = set_level(pk_level)
    
    emit_signal("level_loaded")


func set_level(level) -> Level:
    unload_current_level()
    
    if not level:
        printerr("Tried to load_level a null!")
        return null

    current_level = level.instance()
    add_child(current_level)
    
    return current_level


func unload_current_level():
    if not current_level:
        return
        
    current_controller.clear_controlled()
    
    current_level.queue_free()
    current_level = null


func set_local_player(player):
    if not current_controller:
        printerr("Can't set local player: controller is null")
        return

    current_controller.set_controlled(player)
    current_controller.activate()


func get_current_controller() -> Controller:
    return current_controller
