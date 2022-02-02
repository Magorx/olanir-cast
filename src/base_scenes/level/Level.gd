extends Node2D


class_name Level


export var in_game_name: String
export var team_count: int = 2


var teams = []


func _ready():
    team_count += 1
    for __ in range(team_count):
        teams.append([])


func add_spawn_area(area_node):
    if not area_node is SpawnArea:
        return

    $SpawnAreas.add_child(area_node)


func get_spawn_areas(team):
    var ret = []
    for area in $SpawnAreas.get_children():
        if area.team == team:
            ret.append(area)

    return ret


func get_random_spawn_area(team):
    var areas = get_spawn_areas(team)
    if not areas.size():
        return null

    var rnd = abs(randi()) % areas.size()
    return areas[rnd]


func team_autochoice():
    var team = 1
    var min_team_size = 1000

    for i in range(1, team_count):
        if teams[i].size() < min_team_size:
            min_team_size = teams[i].size()
            team = i
    
    return team


func add_creature(creature, team=0):
    if team >= 0:
        creature.team = team
    else:
        if team == GameInfo.TEAM_AUTOCHOICE:
            creature.team = team_autochoice()
    
    teams[creature.team].append(creature)

    $Creatures.add_child(creature)
    creature.set_state("ready_to_spawn")

    return creature
