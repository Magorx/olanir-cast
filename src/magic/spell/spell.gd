class_name Spell


var rune_chain := RuneChain.new()


func add_rune(rune):
    rune_chain.add(rune)


func cast(caster, position, direction) -> bool:
    var rune = rune_chain.take()
    if not rune:
        return false
    
    rune.on_cast(caster, position, direction, rune_chain.duplicate())
    
    rune_chain.reset()
    
    return true
