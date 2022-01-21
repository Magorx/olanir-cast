class_name Rune


var caster
var cast_position
var cast_direction
var rune_chain


func modify_rune(rune):
    return rune


func cast(_caster_, _position, _direction, _rune_chain_: RuneChain) -> bool:
    return false


func on_cast(caster_, position, direction, rune_chain_: RuneChain) -> bool:
    caster = caster_
    cast_position = position
    cast_direction = direction
    rune_chain = rune_chain_
    
    on_start()
    
    return true


func on_start():
    pass


func on_end():
    pass


func duplicate_no_chain():
    var dup = get_script().new()
    dup.caster = caster
    dup.cast_position = cast_position 
    dup.cast_direction = cast_direction
    dup.rune_chain = null
    
    return dup
