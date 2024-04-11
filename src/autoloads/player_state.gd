extends Node

#can you use an onready in a autoload? when is an autoload put in the scene???

func has_boots():
	var current_scene = _get_current_scene()
	var player:Player = current_scene.get_node("Player")
	return player.has_boots

# ion know what this returns
func _get_current_scene():
	return get_tree().get_root().get_children()[0]
