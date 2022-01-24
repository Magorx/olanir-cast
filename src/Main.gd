extends Node


var pk_wizard = preload("res://wizard.tscn")
var pk_arena1 = preload("res://collection/levels/Arena1.tscn")


func _ready():
    randomize()
    
    var level = Game.load_level(pk_arena1)
    
    level.add_controlled_creature(pk_wizard, 1)
    
    add_child(level)
    
