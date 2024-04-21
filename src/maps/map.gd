class_name Map
extends Node2D

# we need to add a collision shape to the tilemap for the player raycast to be able to detect it, otherwise it'll be considered null.
var id:int

@onready var tilemap:TileMap = $TileMap
func _ready() -> void:
	tilemap.add_to_group('wall')


func _process(delta: float) -> void:
	pass
