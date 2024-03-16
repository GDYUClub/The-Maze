extends Area2D

var dir:= Vector2.ZERO
const TILE_SIZE:= 16


func _init() -> void:
	add_to_group('player')

func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up")
