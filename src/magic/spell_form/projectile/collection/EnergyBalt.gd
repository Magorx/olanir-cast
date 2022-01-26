extends Projectile


func _ready():
    pass


func on_expire():
    stop()
    $AnimatedSprite.play("boom")
    yield($AnimatedSprite, "animation_finished")
    .on_expire()
