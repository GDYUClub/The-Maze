extends Node

# these are functions that are meant to be called in the dialog system
# should probably re-name this script to something more descriptive


func _give_item(id:String):
	ItemDb.give_item(id)

	#var ui = current_scene.get_node("UI")
	#ui.bootIcon.visible = true

func _has_item(item_id) -> bool:
	var current_scene = _get_current_scene()
	var player:Player = current_scene.get_node("Player")
	return player.has_item(item_id)



# this value keeps changing based on the amount of autoloads we have
func _get_current_scene():
	return get_tree().get_root().get_children()[-1]

