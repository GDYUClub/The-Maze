class_name player
extends Area2D

@onready var raycast := $RayCast2D

const TILE_SIZE := 16

func _init() -> void:
	add_to_group("player")

func _ready() -> void:
	raycast.collide_with_areas = true

func get_input_vector(event: InputEvent) -> Vector2:
	# make vector representing player input
	var dir := Vector2.ZERO
	if event.is_action_pressed("ui_up"):
		dir.y -= 1
	if event.is_action_pressed("ui_down"):
		dir.y += 1
	if event.is_action_pressed("ui_left"):
		dir.x -= 1
	if event.is_action_pressed("ui_right"):
		dir.x += 1
	return dir


func _unhandled_input(event: InputEvent) -> void:
	var _input_dir := get_input_vector(event)
	#check what group the next tile is in based on your raycast
	if _input_dir != Vector2.ZERO:
		_move(_input_dir)
		return
	if event.is_action_pressed('inspect'):
		_inspect()



func _move(_input_dir:Vector2) -> void:
	raycast.target_position = _input_dir * TILE_SIZE
	# clear old raycast collison then get new one
	raycast.force_raycast_update()
	var next_tile: Object = raycast.get_collider()

	if next_tile != null:
		print(next_tile)
	else:
		position += _input_dir * TILE_SIZE


func _inspect() -> void:
	raycast.force_raycast_update()
	var inspect_tile: Object = raycast.get_collider()
	if inspect_tile == null:
		print('wow nothing!')
		return
	if inspect_tile.is_in_group('chest'):
		inspect_tile._on_inspection()
		#chest event
		pass


	pass
