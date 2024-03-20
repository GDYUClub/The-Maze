extends Node2D

@onready var ui:UI = $UI
@onready var player:Player = $Player
@onready var map = $Map

#Packed tilemaps!
var tilemap_array: Array[PackedScene] = []

var in_cutscene := false

func _ready() -> void:
	ui.text_rendered.connect(_start_cutscene)
	ui.text_removed.connect(_end_cutscene)
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var current_tilemap = map.get_child(0)
		current_tilemap.queue_free()
		###Do something with random tilemaps?
		pass
		


func _start_cutscene() -> void:
	in_cutscene = true
	player.is_actionable = false

func _end_cutscene() -> void:
	in_cutscene = false
	await get_tree().create_timer(0.01).timeout # 10ms buffer hack to prevent input collision from text advancing and player input, could also solve by checking UI input in player _input event?
	player.is_actionable = true
