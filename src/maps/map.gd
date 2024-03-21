class_name Map
extends Node2D

@onready var tilemap:TileMap = $TileMap
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tilemap.add_to_group('wall')
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
