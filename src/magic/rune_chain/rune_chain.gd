class_name RuneChain


var data = []
var cur_idx = 0


func add(rune):
    data.append(rune)


func take():
    if cur_idx >= data.size():
        return null
    else:
        var rune = data[cur_idx]
        cur_idx += 1
        return rune


func reset():
    cur_idx = 0


func duplicate():
    var dup = get_script().new()
    dup.data = data.duplicate()
    dup.cur_idx = cur_idx
    
    return dup
