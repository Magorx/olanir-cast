class_name Damage


const numbers_alive_time: float = 1.0
const numbers_font_size: int = 20


enum Type {
    energy,
    
    fire,
    water,
    air,
    earth,
    
    lightning,
   }


const Colors = {
    Type.energy    : Color(190,  60, 240, 255) / 255,
    Type.water     : Color( 60, 190, 240, 255) / 255,
    Type.fire      : Color(248, 70,   0, 255) / 255,
    Type.air       : Color(180, 215, 210, 255) / 255,
    Type.earth     : Color(130, 130, 90, 255) / 255,
    Type.lightning : Color(250, 250,  45, 255) / 255,
   }


func get_color(type_):
    if type_ in Colors.keys():
        return Colors[type_]
    else:
        return Color(255, 255, 255, 255) / 255


class Resistances:
    var value = {
        Type.energy    : 0,
        Type.water     : 0,
        Type.fire      : 0,
        Type.air       : 0,
        Type.earth     : 0,
        Type.lightning : 0
       }
    
    func get(key):
        if key in value.keys():
            return value[key]
        else:
            return 0


var type
var value
var color

func _init(type_, value_, color_override=null):
    type = type_
    value = value_
    if color_override:
        color = color_override
    else:
        color = get_color(type)


func damage_overriden(damage: int):
    return get_script().new(type, damage, color)
