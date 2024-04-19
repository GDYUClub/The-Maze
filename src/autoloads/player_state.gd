extends Node

# these are functions that can be called in the dialog system
# should probably re-name to something more descriptive

func has_boots():
	var current_scene = _get_current_scene()
	var player:Player = current_scene.get_node("Player")
	return player.has_boots

func _give_boots():
	var current_scene = _get_current_scene()
	var player:Player = current_scene.get_node("Player")
	ItemDb.give_item("test0")

	#var ui = current_scene.get_node("UI")
	#ui.bootIcon.visible = true



# this value keeps changing based on the amount of autoloads we have
func _get_current_scene():
	return get_tree().get_root().get_children()[-1]

