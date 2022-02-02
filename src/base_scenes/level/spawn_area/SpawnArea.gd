extends Area2D


class_name SpawnArea


export var team: int = 0


func _ready():
    pass


func generate_random_point_inside():
    return position


func get_fallback_point():
    return position


func spawn_creature_final(point, creature: Creature):
    creature.position = point


func spawn_creature(creature):
    var point = position
    spawn_creature_final(point, creature)
