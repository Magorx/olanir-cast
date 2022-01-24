extends Node


export var max_hp: int = 100
export var max_mp: int = 100


var hp = max_hp
var mp = 0


export var respawn_time: float = 1


export var move_speed:        float = 7
export var move_attack_time:  float = 0.2
export var move_release_time: float = 0.2


#export var slide_speed_multiplier:  float = 1.5
#export var slide_time:              float = 0.75
#export var slide_attack_time:       float = 0.1
#export var slide_release_time:      float = 0.35


export var resist_energy:    int = 0
export var resist_fire:      int = 0
export var resist_water:     int = 0
export var resist_air:       int = 0
export var resist_earth:     int = 0
export var resist_lightning: int = 0


var resists: Damage.Resistances


func _ready():
    move_speed *= GameInfo.TILE_SIZE
    
    resists = Damage.Resistances.new()
    resists.value[Damage.Type.energy]    = resist_energy
    resists.value[Damage.Type.fire]      = resist_fire
    resists.value[Damage.Type.water]     = resist_water
    resists.value[Damage.Type.air]       = resist_air
    resists.value[Damage.Type.earth]     = resist_earth
    resists.value[Damage.Type.lightning] = resist_lightning
