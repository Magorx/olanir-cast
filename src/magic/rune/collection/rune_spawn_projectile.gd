extends Rune


class_name RuneSpawnProjectile


var projectile_type: String
var proj: Projectile


func set_projectile_type(type) -> Rune:
    projectile_type = type
    return self


func modify_projectile(_proj):
    pass


func on_cast(caster, position, direction, rune_chain_: RuneChain) -> bool:
    if not .on_cast(caster, position, direction, rune_chain_):
        return false
    
    var shared_proj = Network.SharedNode.new(projectile_type, caster.get_parent())
    proj = shared_proj.node

    modify_projectile(proj)
    
    var shift = Vector2(0, 0)
    if caster.position == cast_position:
        shift = shift_projectile_from_caster()
    
#    caster.get_parent().add_child(proj)
    
    var _ign = null
    
    _ign = proj.connect("fired", self, "on_proj_fire")
    _ign = proj.connect("hit", self, "on_proj_hit")
    _ign = proj.connect("hit_unit", self, "on_proj_hit_unit")
    _ign = proj.connect("lifetime_expired", self, "on_proj_lifetime_expired")
    _ign = proj.connect("expired", self, "on_proj_expired")

    proj.on_fire(caster, cast_position + shift, cast_direction)

    shared_proj.share()
    
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


func shift_projectile_from_caster():
    var shift = cast_direction * (caster.cast_radius + proj.safecast_shift * 2 + 1)

    var dot = caster.direction.dot(caster.actual_velocity.normalized())
    
    if dot > 0:
        shift += cast_direction * caster.cast_radius * dot
    
    return shift


func duplicate_no_chain():
    var dup = .duplicate_no_chain()
    dup.projectile_type = projectile_type
    
    return dup
