extends RuneSpawnProjectile


class_name RuneSpawnTriggerProjectile


func on_proj_hit(collision: KinematicCollision2D):
    var rune = rune_chain.take()
    if not rune:
        return
    
    rune.on_cast(caster, collision.position + collision.normal * 10, collision.normal, rune_chain)
