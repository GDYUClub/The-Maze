extends Area2D

@onready var raycast := $RayCast2D

var input_dir:= Vector2.ZERO
const TILE_SIZE:= 16


func _init() -> void:
	add_to_group('player')

#func get_player_input() -> Vector2:
	## make vector representing player input
	#var dir := Vector2.ZERO
	##dir.x = Input.get_axis("ui_left","ui_right")
	##dir.y = Input.get_axis("ui_up","ui_down")
	#if Input.is_action_just_pressed("ui_up"):
		#dir.y += -1
	#if Input.is_action_just_pressed("ui_down"):
		#dir.y += 1
	#if Input.is_action_just_pressed("ui_left"):
		#dir.x += -1
	#if Input.is_action_just_pressed("ui_right"):
		#dir.x += 1
	## prioritizes left/right movement to up/down movement in diagonal inputs.
	#if dir.x != 0 and dir.y != 0:
		#dir.y = 0
	#return dir

#func _process(delta: float) -> void:
	##check what group the next tile is in based on your raycast
	#input_dir = get_player_input()
	#if input_dir == Vector2.ZERO:
		#return
	#raycast.target_position = input_dir * TILE_SIZE
	## should make some sort of tileItem class
	#var next_tile :Object = raycast.get_collider()
	#if next_tile == null:
		#return
	#print(next_tile)
	#position += input_dir * TILE_SIZE


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		print('up')