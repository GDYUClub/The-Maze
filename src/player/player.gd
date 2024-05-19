class_name Player
extends Area2D

@onready var boots_packed_scene: PackedScene = preload("res://src/boots/boots.tscn")
@onready var raycast := $RayCast2D

signal walked_into_stairs(toward_which_room_id)
signal moved(dir)

const dialogBox = preload("res://assets/dialogue_boxes/balloon.tscn")
@export var dialog_resource: DialogueResource
@export var dialog_start: String = "start"

const TILE_SIZE := 16
var is_actionable:= true

var inventory := []

var has_boots := false

var equipped_item:Item

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

	if event.is_action_pressed('interact'):
		_interact()

	if event.is_action_pressed('menu'):
		# don't try this at home
		get_parent()._toggle_menu(inventory)

func _move(_input_dir:Vector2) -> void:
	raycast.target_position = _input_dir * TILE_SIZE
	# clear old raycast collison then get new one
	raycast.force_raycast_update()
	var next_tile: Object = raycast.get_collider()
	
	if next_tile != null and next_tile.is_in_group('npc'):
		next_tile.npc_interaction()
		pass
	if next_tile != null and next_tile.is_in_group('chest'):
		if !has_boots:
			give_boots()
		var balloon: Node = dialogBox.instantiate()
		self.add_child(balloon)
		balloon.start(next_tile.dialog_resource,dialog_start)
		pass

	if next_tile == null or next_tile.is_in_group('walkable'):
		position += _input_dir * TILE_SIZE
		moved.emit(_input_dir)
		check_next_tile(next_tile)

func check_next_tile(tile: Object) -> void:
	if tile == null:
		return
	if tile.is_in_group('stairs'):
		walked_into_stairs.emit(tile.toward_room_id)

func _interact() -> void:
	raycast.force_raycast_update()
	var interact_tile: Object = raycast.get_collider()
	if interact_tile == null:
		print('wow nothing!')
		return
	if interact_tile.is_in_group('interact'):
		interact_tile._on_interaction(self)


func give_boots():
	var boots = boots_packed_scene.instantiate()
	add_child(boots)
	has_boots = true

func has_item(id:String) -> bool:
	for item in inventory:
		if item.id == id:
			return true
	return false

func has_item_equipped(id:String) -> bool:
	return equipped_item.id == id

