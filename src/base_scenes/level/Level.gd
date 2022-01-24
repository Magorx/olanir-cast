extends Node2D


class_name Level


var pk_controller = preload("res://utils/controller/Controller.tscn")


func _ready():
    pass # Replace with function body.


func add_spawn_area(area_node):
    if not area_node is SpawnArea:
        return

    $SpawnAreas.add_child(area_node)


func get_spawn_areas(team):
    var ret = []
    for area in $SpawnAreas.get_children():
        print(area, " ", area.team)
        if area.team == team:
            ret.append(area)

    return ret


func get_random_spawn_area(team):
    var areas = get_spawn_areas(team)
    if not areas.size():
        return null

    var rnd = abs(randi()) % areas.size()
    return areas[rnd]


func add_controlled_creature(pk_creature, team=0):
    var creature = pk_creature.instance()
    creature.team = team
    
    var controller = pk_controller.instance()
    
    controller.set_controlled(creature)
    
    $Creatures.add_child(creature)
    $Controllers.add_child(controller)
    
    creature.set_state("dead")
