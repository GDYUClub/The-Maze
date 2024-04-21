extends Node2D

@onready var menuLayer = $MenuLayer
@onready var player:Player = $Player
@onready var current_map:Node2D = $Map

var current_map_id = 1

func _ready() -> void:
	player.walked_into_stairs.connect(change_map)

func change_map(next_map_id: int) -> void:
	var next_map_path :String = "res://src/maps/map-%s.tscn" % str(next_map_id)
	var nextMap:Map = load(next_map_path).instantiate()
	#load new map
	current_map.queue_free()
	add_child(nextMap)
	current_map = nextMap

	#move the player to the spawn point
	var playerSpawnMarker:Marker2D = nextMap.get_node('PlayerSpawn')
	player.position = playerSpawnMarker.position

func on_teleport_entered() -> void:
	var next_map_id :int = current_map_id + 2
	match current_map_id:
		77:
			print("can't teleport")
		11:
			next_map_id = 2
		10:
			next_map_id = 1
		_:
			next_map_id = current_map_id + 2

	var next_map_path :String = "res://src/maps/map-%s.tscn" % str(next_map_id)
	var nextMap:Map = load(next_map_path).instantiate()

	#Check if you'd go to an empty tile
	var potential_tile_position = nextMap.get_node("TileMap").local_to_map(player.position)
	var potential_tile = nextMap.get_node("TileMap").get_cell_tile_data(0, potential_tile_position)

	if potential_tile != null:
			print("can't teleport")

	# go to new map
	current_map.queue_free()
	add_child(nextMap)
	current_map = nextMap
	current_map_id = next_map_id

func _toggle_menu(inventory) -> void:
	menuLayer.visible = true
	menuLayer._load_items(inventory)
	pass

