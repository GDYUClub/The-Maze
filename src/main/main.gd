extends Node2D

@onready var ui:UI = $UI
@onready var player:Player = $Player
@onready var current_map:Node2D = $Map

var in_cutscene := false

var maps:Array = [preload('res://src/maps/map-1.tscn'),preload('res://src/maps/map-2.tscn'),preload('res://src/maps/map-3.tscn')]
var map_room_id_dict: Dictionary = { #Not perfect but works for time constraint
	1 : preload('res://src/maps/map-1.tscn'),
	2: preload('res://src/maps/map-2.tscn'),
	3: preload('res://src/maps/map-3.tscn')
}

var shuffled_maps:Array = []

var current_map_id

func _ready() -> void:
	ui.text_rendered.connect(_start_cutscene)
	ui.text_removed.connect(_end_cutscene)
	player.walked_into_stairs.connect(next_map)
	pass

func next_map(given_room_id: int) -> void:
	var next_map_id :int = given_room_id
	var nextMap:Node2D = map_room_id_dict[next_map_id].instantiate()
	#load new map
	current_map.queue_free()
	add_child(nextMap)
	current_map = nextMap

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


func _start_cutscene() -> void:
	in_cutscene = true
	player.is_actionable = false

func _end_cutscene() -> void:
	in_cutscene = false
	await get_tree().create_timer(0.01).timeout # 10ms buffer hack to prevent input collision from text advancing and player input, could also solve by checking UI input in player _input event?
	player.is_actionable = true


# ---
# Copy of hint code.
# I'll rearrange this later. --nd
class Hint:
	var contents: String
	var is_unlocked: bool
	func _init(contents: String) -> void:
		self.contents = contents
		self.is_unlocked = false
	
	func unlock() -> void:
		self.is_unlocked = true

# all hints in game in a nested array
var hints = [[], []]


# level number should be given directly; function handles offsetting for 0-indexing
func add_hint(level: int, content: String) -> void:
	hints[level - 1].append(Hint.new(content))

func all_level_hints_unlocked(level) -> bool:
	var hints_to_check = hints[level - 1].duplicate()
	hints_to_check.reduce(func(hint): return !hint.is_unlocked)
	if hints_to_check.is_empty():
		return true
	else:
		return false
