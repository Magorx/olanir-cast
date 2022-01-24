extends Node


var AVAILABLE_LIGHTNING_Z_INDEX = []

var current_level: Level


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
    current_level = level.instance()
    return current_level
