extends Node2D

@onready var menuLayer = $MenuLayer
@onready var player:Player = $Player
@onready var current_map:Node2D = $Map
var in_cutscene := false

var maps:Array = [preload('res://src/maps/map-1.tscn'),preload('res://src/maps/map-2.tscn'),preload('res://src/maps/map-3.tscn')]
var map_room_id_dict: Dictionary = { #Not perfect but works for time constraint
	1 : preload('res://src/maps/map-1.tscn'),
	2: preload('res://src/maps/map-2.tscn'),
	3: preload('res://src/maps/map-3.tscn'),
	4 : preload('res://src/maps/map-4.tscn'),
	5: preload('res://src/maps/map-5.tscn'),
	6: preload('res://src/maps/map-6.tscn'),
	77: preload('res://src/maps/map-77.tscn')
}


###Add the credits inventory

var floor_popup_disappearing = false

var shuffled_maps:Array = []

var current_map_id = 1
var global_floor_tween: Tween


func _ready() -> void:
	#ui.text_rendered.connect(_start_cutscene)
	#ui.text_removed.connect(_end_cutscene)
	player.walked_into_stairs.connect(next_map)
	global_floor_tween = get_tree().create_tween()
	give_all_items()
	pass

func next_map(given_map_id: int) -> void:
	var next_map_id :int = given_map_id
	current_map_id = given_map_id
	var nextMap:Node2D = map_room_id_dict[next_map_id].instantiate()
	#load new map
	current_map.queue_free()
	add_child(nextMap)
	current_map = nextMap
	var playerSpawnMarker:Marker2D = nextMap.get_node('PlayerSpawn')
	player.position = playerSpawnMarker.position
	flash_floor_pickup()

func flash_floor_pickup():
			global_floor_tween.kill()
			$FloorPopup.modulate.a = 1
			global_floor_tween =  get_tree().create_tween()
			global_floor_tween.connect("finished",func(): make_floor_popup_disappear(),CONNECT_ONE_SHOT)
			global_floor_tween.tween_property($FloorPopup, "modulate:a", 0, 5)
			global_floor_tween.play()
			$FloorPopup/FloorLabel.text = str(current_map_id) ###NXT fix this and make it tween
			#move the player to the spawn point
			pass
	

func make_floor_popup_disappear():
	$FloorPopup.modulate.a = 0

	
	pass

func on_teleport_requested() -> bool:
	var next_map_id :int = current_map_id + 2
	match current_map_id:
		77:
			return false
		5:
			next_map_id = 1
		6:
			next_map_id = 2
		_:
			next_map_id = current_map_id + 2
	var nextMap:Node2D = map_room_id_dict[next_map_id].instantiate()
	current_map_id = next_map_id
	add_child(nextMap)
	nextMap.visible = false
	#Check if at tile or not
	var potential_tile_position = nextMap.get_node("TileMap").local_to_map(player.position)
	var potential_tile = nextMap.get_node("TileMap").get_cell_tile_data(0, potential_tile_position)
	
	if potential_tile == null:
		nextMap.visible = true
		current_map.queue_free()
		current_map = nextMap
	else:
		nextMap.queue_free()
		return false
	
	#load new map
	return true

	#move the player to the spawn point
	var playerSpawnMarker:Marker2D = nextMap.get_node('PlayerSpawn')
	player.position = playerSpawnMarker.position
	pass

func swap_map() -> void:
	#reshuffle rooms if we've visted them all
	if shuffled_maps.size() == 0:
		shuffled_maps = Array(range(maps.size()))
		shuffled_maps.shuffle()
	#pick new room from remaining choices
	var next_map_id :int = shuffled_maps.pop_front()
	var nextMap:Node2D = maps[next_map_id].instantiate()

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

func on_win_requested():
	if current_map_id == 4:
		print("YOU WONWUYIOWNWUIWNBWVGHUJKMNBGHUJMNBVFGHJNBVFGHJNBVGHNBVGHNBVFGUJMNB CFGYUIKMNBCFGJMNBVFGHJMNBVFGHJNBVGHJ")
		get_tree().change_scene_to_file("res://src/main/win_scene.tscn")
	pass

func give_all_items():
	ItemDb.give_item("1")
	ItemDb.give_item("2")
	ItemDb.give_item("3")
	ItemDb.give_item("4")
	ItemDb.give_item("5")
	ItemDb.give_item("6")
	ItemDb.give_item("7")
	ItemDb.give_item("8")
	ItemDb.give_item("9")
	ItemDb.give_item("10")
	ItemDb.give_item("11")

#unused, will remove later
#func _start_cutscene() -> void:
	#in_cutscene = true
	#player.is_actionable = false

#func _end_cutscene() -> void:
	#in_cutscene = false
	#await get_tree().create_timer(0.01).timeout # 10ms buffer hack to prevent input collision from text advancing and player input, could also solve by checking UI input in player _input event?
	#player.is_actionable = true
