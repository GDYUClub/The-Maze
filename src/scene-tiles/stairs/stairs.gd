extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group('walkable')
	add_to_group('stairs')
	pass # Replace with function body.

