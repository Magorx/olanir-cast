extends Projectile


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func on_fire(caster, position_ : Vector2, velocity_ : Vector2):
    .on_fire(caster, position_, velocity_)
    $AnimatedSprite.play("idle")


func on_expire():
    $CollisionShape2D.set_deferred("disabled", true)
    $AnimatedSprite.play("boom")
    yield($AnimatedSprite, "animation_finished")
    .on_expire()
