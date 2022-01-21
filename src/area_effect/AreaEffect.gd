extends Area2D


class_name AreaEffect


export var expire_time: float = 1
export var tps: int = 5
export var oneshot: bool = false


signal appeared
signal effect_tick
signal unit_entered(unit)
signal creature_entered(creature)
signal lifetime_end
signal expired


func _ready():
    $ExpireTimer.wait_time = expire_time
    $ExpireTimer.start()
    
    $TickTimer.wait_time = 1 / max(tps, 1)
    $TickTimer.start()


func on_appear(pos, dir):
    position = pos
    emit_signal("appeared")


func on_effect_tick():
    emit_signal("effect_tick")
    if oneshot:
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
