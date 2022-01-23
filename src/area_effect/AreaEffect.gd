extends Area2D


class_name AreaEffect


export var expire_time: float = 1
export var tps: int = 5
export var one_shot: bool = false
export var caster_team_affected: bool = false
export var ignores_obstacles: bool = false


var caster

var lightning_z_index

signal appeared
signal effect_tick
signal unit_entered(unit)
signal creature_entered(creature)
signal lifetime_end
signal expired


func _ready():
    $ExpireTimer.wait_time = expire_time
    $ExpireTimer.start()
    
    $TickTimer.wait_time = 1.0 / max(tps, 1)
    $TickTimer.start()
    
    if ignores_obstacles:
        $Light2D.queue_free()
        $AnimatedSprite.material.set_light_mode(CanvasItemMaterial.LIGHT_MODE_NORMAL)
    
    lightning_z_index = GameInfo.get_lightning_z_index()
    if (!lightning_z_index):
        $Light2D.enabled = false
    else:
#        $Light2D.z_index = lightning_z_index
        $Light2D.range_z_min = lightning_z_index
        $Light2D.range_z_max = lightning_z_index
        $AnimatedSprite.z_index = lightning_z_index
        $AnimatedSprite.z_as_relative = false

var Dot = preload("res://WhiteDot.tscn")

func get_overlapping_bodies(target_teams_only=true, ignore_obstacles=false):
    var bodies = .get_overlapping_bodies()
    
    var team_filtered_bodies = []
    if target_teams_only and not caster_team_affected:
        for obj in bodies:
            if (caster as Unit).same_team(obj):
                pass
            team_filtered_bodies.append(obj)
    else:
        team_filtered_bodies = bodies
            
    
    if ignores_obstacles:
        return bodies
    
    var ret = []
    for obj in team_filtered_bodies:
        var dir = obj.position - position
        
        var space_state = get_world_2d().direct_space_state
        var intersection = space_state.intersect_ray(position, obj.position)
        
        if (not intersection.keys()) or intersection["collider"] == obj:
            ret.append(obj)
    
    return ret


func on_appear(caster_, pos, _dir):
    caster = caster_
    position = pos
    emit_signal("appeared")
    
    if one_shot:
        $TickTimer.wait_time = GameInfo.EPS
        $TickTimer.one_shot = true


func on_effect_tick():
    emit_signal("effect_tick")
    if one_shot:
        on_expire()


func on_unit_enter(unit: Unit):
    emit_signal("unit_entered", unit)


func on_creature_enter(creature: Creature):
    emit_signal("creature_entered", creature)


func on_lifetime_end():
    emit_signal("lifetime_end")
    on_expire()


func on_expire():
    emit_signal("expired")
    queue_free()


func _on_AreaEffect_body_entered(body):
    if body is Unit:
        on_unit_enter(body as Unit)
    if body is Creature:
        on_creature_enter(body as Creature)


func _exit_tree():
    GameInfo.release_lightning_z_index(lightning_z_index)
