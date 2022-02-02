extends Node


var current: Node = null

var menu_stack = []


var preloaded = {
	"main_menu"                 : preload("res://menus/main_menu/MainMenu.tscn"),
	"matchmaking"               : preload("res://menus/matchmaking/Matchmaking.tscn"),
	"matchmaking_join"          : preload("res://menus/matchmaking_join/MatchmakingJoin.tscn"),
	"matchmaking_host"          : preload("res://menus/matchmaking_host/MatchmakingHost.tscn"),
	
	"ingame_hud"                : preload("res://menus/ingame_hud/IngameHUD.tscn")
   }


func _ready():
    switch_to("matchmaking")



func get_preloaded_interface(name):
	if not name in preloaded.keys():
		return null
	else:
		return preloaded[name]


func switch_to(interface_name, to_reset_stack=true, to_stack_add=true):
	var pk_interface = get_preloaded_interface(interface_name)
	if not pk_interface:
		printerr("Can't find preload menu [", interface_name, "]")
		return
	
	if to_reset_stack:
		menu_stack = []

	if to_stack_add:
		menu_stack.append(interface_name)
	
	set_current(pk_interface)


func descend_to(interface_name):
	switch_to(interface_name, false)


func ascend():
	if menu_stack.size() <= 1:
		printerr("Can't menu-ascend, stack is empty or 1-elemented")
		return

	menu_stack.pop_back()

	switch_to(menu_stack.back(), false, false)
	

func set_current(pk_interface):
	clear_current()

	current = pk_interface.instance()
	add_child(current)


func clear_current():
	if not current:
		return
	
	current.queue_free()
	current = null


#func focus():
#    var parent = get_parent()
##    parent.move_child(self, 0)
#    parent.move_child(self, parent.get_child_count() + 1)


func add(something):
	add_child(something)
