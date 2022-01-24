extends RuneSpawnProjectile


class_name RuneSpawnTriggerProjectile


func on_proj_hit(collision: KinematicCollision2D):
    var rune = rune_chain.take()
    if not rune:
        return
    
    rune.on_cast(caster, collision.position + collision.normal * 10, collision.normal, rune_chain)


func on_proj_lifetime_expired():
    var rune = rune_chain.take()
    if not rune:
        return
    
    rune.on_cast(caster, proj.position, proj.velocity, rune_chain)    
