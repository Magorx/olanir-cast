extends Node


var AVAILABLE_LIGHTNING_Z_INDEX = []

var current_level: Level


var pk_wizard = preload("res://wizard.tscn")


func _ready():
    for i in range(GameInfo.MIN_LIGHTNING_Z_INDEX, GameInfo.MAX_LIGHTNING_Z_INDEX):
        AVAILABLE_LIGHTNING_Z_INDEX.append(i)


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


func load_level(level) -> Level:
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
    
    current_level.queue_free()
    current_level = null


func add_local_player(team=1):
    if not current_level:
        printerr("add_local_player is called when there is no loaded level")
    
    current_level.add_controlled_creature(pk_wizard, team)
