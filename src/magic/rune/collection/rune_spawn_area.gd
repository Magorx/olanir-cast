extends Rune


class_name RuneSpawnAreaEffect


var area_type


func set_area_type(type) -> Rune:
    area_type = type
    return self


func modify_area(_area):
    pass


func on_cast(caster_, position, direction, rune_chain_: RuneChain) -> bool:
    if not .on_cast(caster_, position, direction, rune_chain_):
        return false
    
    var area: AreaEffect = area_type.instance()
    modify_area(area)
    
    var _ign = null
    
    _ign = area.connect("appeared", self, "on_area_appeared")
    _ign = area.connect("effect_tick", self, "on_area_effect_tick")
    _ign = area.connect("unit_entered", self, "on_area_unit_entered")
    _ign = area.connect("creature_entered", self, "on_area_creature_entered")
    _ign = area.connect("lifetime_end", self, "on_area_lifetime_end")
    _ign = area.connect("expired", self, "on_area_expired")
    
    caster.get_parent().add_child(area)
    area.on_appear(position, direction)
    
    return true


func on_area_appeared():
    pass


func on_area_effect_tick():
    pass


func on_area_unit_entered(_unit):
    pass


func on_area_creature_entered(_creature):
    pass


func on_area_lifetime_end():
    pass


func on_area_expired():
    pass
