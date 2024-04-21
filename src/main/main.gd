extends Node2D

@onready var menuLayer = $MenuLayer
@onready var player:Player = $Player
@onready var current_map:Node2D = $Map

var current_map_id

func _ready() -> void:
	#ui.text_rendered.connect(_start_cutscene)
	#ui.text_removed.connect(_end_cutscene)
	player.walked_into_stairs.connect(next_map)
	pass

func next_map(next_room_id: int) -> void:
	var next_map_path :String = "res://src/maps/map-%s.tscn" % str(next_room_id)
	var nextMap:Map = load(next_map_path).instantiate()
	#load new map
	current_map.queue_free()
	add_child(nextMap)
	current_map = nextMap

	#move the player to the spawn point
	var playerSpawnMarker:Marker2D = nextMap.get_node('PlayerSpawn')
	player.position = playerSpawnMarker.position

func _toggle_menu(inventory) -> void:
	menuLayer.visible = true
	menuLayer._load_items(inventory)
	pass

