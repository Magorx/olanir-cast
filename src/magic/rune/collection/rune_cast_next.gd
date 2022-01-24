extends Rune


class_name RuneCastNext


func cast(caster_, position, direction, rune_chain_: RuneChain) -> bool:
    return on_cast(caster_, position, direction, rune_chain_)


func on_cast(caster_, position, direction, rune_chain_: RuneChain) -> bool:
    if not .on_cast(caster_, position, direction, rune_chain_):
        return false
    
    var rune = rune_chain.take()
    if not rune:
        return on_nothing_to_cast()
    
    var modified_rune = modify_rune(rune)
    return modified_rune.on_cast(caster, cast_position, cast_direction, rune_chain)


func on_nothing_to_cast():
    return false


