extends Node

const SPEED_LERP_COEF = 0.25
const TILE_SIZE = 64
const EPS = 1e-5

const MIN_VELOCITY = 1
const MIN_VELOCITY_SQUARED = MIN_VELOCITY * MIN_VELOCITY

const MAX_CASTING_LEVEL = 10
const CASTING_LEVEL_DEFAULT = 5
const CASTING_LEVEL_MOVE_RELEASE_ATTACK = 4
const CASTING_LEVEL_MOVE = 3


const HIT_HIGHLIGHT_TIME = 0.75


const MIN_LIGHTNING_Z_INDEX = 10
const MAX_LIGHTNING_Z_INDEX = 100
var AVAILABLE_LIGHTNING_Z_INDEX = []


func _ready():
    for i in range(MIN_LIGHTNING_Z_INDEX, MAX_LIGHTNING_Z_INDEX):
        AVAILABLE_LIGHTNING_Z_INDEX.append(i)


func get_lightning_z_index():
    if not AVAILABLE_LIGHTNING_Z_INDEX.size():
        return 0
    
    var idx = AVAILABLE_LIGHTNING_Z_INDEX.back()
    AVAILABLE_LIGHTNING_Z_INDEX.pop_back()
    
    return idx


func release_lightning_z_index(idx):
    if idx < MIN_LIGHTNING_Z_INDEX or idx > MAX_LIGHTNING_Z_INDEX:
        return
    
    AVAILABLE_LIGHTNING_Z_INDEX.append(idx)
