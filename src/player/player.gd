extends Area2D

@onready var raycast := $RayCast2D

var input_dir:= Vector2.ZERO
const TILE_SIZE:= 16


func _init() -> void:
	add_to_group('player')

func get_input_vector(event:InputEvent) -> Vector2:
	# make vector representing player input
	var dir := Vector2.ZERO
	#dir.x = Input.get_axis("ui_left","ui_right")
	#dir.y = Input.get_axis("ui_up","ui_down")
	if event.is_action_pressed("ui_up"):
		dir.y -= 1
	if event.is_action_pressed("ui_down"):
		dir.y += 1
	if event.is_action_pressed("ui_left"):
		dir.x -= 1
	if event.is_action_pressed("ui_right"):
		dir.x += 1
	print(dir)
	return dir


func _unhandled_input(event: InputEvent) -> void:
	input_dir = get_input_vector(event)
	#check what group the next tile is in based on your raycast
	if input_dir == Vector2.ZERO:
		return
	raycast.target_position = input_dir * TILE_SIZE
	# should make some sort of tileItem class
	var next_tile :Object = raycast.get_collider()
	if next_tile != null:
		print(next_tile)
	position += input_dir * TILE_SIZE