extends Area2D


class_name AreaEffect


export var expire_time: float = 1
export var tps: int = 5
export var one_shot: bool = false
export var caster_team_affected = false


var caster


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
