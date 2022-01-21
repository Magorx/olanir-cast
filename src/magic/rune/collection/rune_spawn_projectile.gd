extends Rune


class_name RuneSpawnProjectile


var projectile_type


func set_projectile_type(type) -> Rune:
    projectile_type = type
    return self


func modify_projectile(proj):
    pass


func on_cast(caster_, position, direction, rune_chain_: RuneChain) -> bool:
    if not .on_cast(caster_, position, direction, rune_chain_):
        return false
    
    var proj: Projectile = projectile_type.instance()
    modify_projectile(proj)
    
    var shift = Vector2(0, 0)
    if caster.position == cast_position:
        shift = shift_projectile_from_caster(proj)
    
    caster.get_parent().add_child(proj)
    
    proj.connect("fired", self, "on_proj_fire")
    proj.connect("hit", self, "on_proj_hit")
    proj.connect("hit_unit", self, "on_proj_hit_unit")
    proj.connect("lifetime_expired", self, "on_proj_lifetime_expired")
    proj.connect("expired", self, "on_proj_expired")

    proj.on_fire(position + shift, direction)
    
    return true


func on_proj_fire():
    pass
    

func on_proj_hit(_collision: KinematicCollision2D):
    pass


func on_proj_hit_unit(_unit):
    pass


func on_proj_lifetime_expired():
    pass


func on_proj_expired():
    pass


func shift_projectile_from_caster(proj):
    var shift = cast_direction * (caster.cast_radius + proj.safecast_shift)

#    if caster.direction.dot(caster.velocity) > 0:
#        shift += caster.velocity.normalized() * caster.max_velocity * (2 / Engine.iterations_per_second)
    
    return shift
