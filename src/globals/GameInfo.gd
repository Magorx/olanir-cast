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
const CASTING_LEVEL_DEAD = 0


const HIT_HIGHLIGHT_TIME = 0.75


const MIN_LIGHTNING_Z_INDEX = 10
const MAX_LIGHTNING_Z_INDEX = 100


const MAX_SPAWN_ATTEMPTS = 20


const TEAM_AUTOCHOICE = -1


const LEVEL_EXTENSION = ".tscn"


const CREATURES = {
    "wizard" : preload("res://wizard.tscn")
   }


func _ready():
    pass
