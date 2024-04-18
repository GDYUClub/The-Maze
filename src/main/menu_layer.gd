extends CanvasLayer
class_name Menu

@onready var itemSlots:Control = $Menu/Panel/ItemSlots
@onready var itemPanel:Panel = $Menu/Panel
@onready var itemCursor:Sprite2D = $Menu/Panel/ItemSlots/ItemCursor
var item_cursor_row := 0
var item_cursor_col := 0
var player_inventory :Array = []

const ROWS = 4
const COLS = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func get_input_vector(event: InputEvent) -> Vector2:
	var dir := Vector2.ZERO
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
	if visible:
		get_viewport().set_input_as_handled()
	var _input_dir := get_input_vector(event)
	if _input_dir != Vector2.ZERO:
		return
	_move_cursor(_input_dir)

func _move_cursor(input_dir) -> void:
	prints(input_dir,item_cursor_col,item_cursor_row,itemCursor.position)
	# move based on the row and column (see that's why I did that!!!)
	# mod to wrap around values
	if abs(input_dir.x) > 0:
		#item_cursor_col = (item_cursor_col + (1 * input_dir.x)) % COLS
		item_cursor_col = item_cursor_col + (1 * input_dir.x)
	elif abs(input_dir.y) > 0:
		#item_cursor_row = (item_cursor_row + (1 * input_dir.y)) % ROWS
		item_cursor_row = item_cursor_row + (1 * input_dir.y)
	print(item_cursor_col,item_cursor_row)
	itemCursor.position.x = item_cursor_col * 32
	itemCursor.position.y = item_cursor_row * 32



func _load_items(new_inventory:Array) -> void:
	player_inventory = new_inventory
	prints("itempalenasd",itemPanel.global_position)
	# make sprite 2ds, pass in the texture
	# put them on the grid
	var item_sprites :Array[Sprite2D] = []
	var margin_x = 8
	var margin_y = 8

	for item in player_inventory:
		print(item)
		var new_sprite := Sprite2D.new()
		new_sprite.texture = item.icon
		item_sprites.append(new_sprite)
	print("item sprites: " ,item_sprites.size())

	for row in ROWS:
		for col in COLS:
			if item_sprites.size() > 0:
				var item_sprite = item_sprites.pop_front()
				print(item_sprite)
				itemPanel.add_child(item_sprite)
				item_sprite.position.x = (32 * col) + 16
				item_sprite.position.y = (20 * row) + 16

	#put it at the rightmost value to start
	itemCursor.position = Vector2(16,16)




