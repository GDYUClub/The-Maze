extends CanvasLayer
class_name Menu

@onready var itemGrid:GridContainer = %ItemGrid
@onready var itemCursor:TextureRect = %ItemCursor
var cursor_pos:= Vector2i(0,0)

var item_icon_scene:PackedScene = preload("res://src/menu/item_ui.tscn")

var player_inventory :Array = []
# y = rows x = columns
var item_grid_bounds:= Vector2i(0,0)

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
	return dir


func _unhandled_input(event: InputEvent) -> void:
	if visible:
		get_viewport().set_input_as_handled()
	var _input_dir := get_input_vector(event)
	if _input_dir != Vector2.ZERO:
		return
	_move_cursor(_input_dir)

func _move_cursor(input_dir) -> void:
	print(input_dir)
	#cursor is 16 + 16 * pos
	#offset is pos - 1 * 8
	if abs(input_dir.x) > 0:
		cursor_pos.x = wrapi(cursor_pos.x + input_dir.x,0,item_grid_bounds.x)
	if abs(input_dir.y) > 0:
		cursor_pos.y = wrapi(cursor_pos.y + input_dir.y,0,item_grid_bounds.y)
	print("new cursor pos:", cursor_pos)


	pass



func _load_items(new_inventory:Array) -> void:
	player_inventory = new_inventory
	for item in player_inventory:
		var new_item_icon := item_icon_scene.instantiate()
		# we just store the id of the item in the icon, not the entire resource
		new_item_icon.id = item.id
		itemGrid.add_child(new_item_icon)
	item_grid_bounds.x = itemGrid.columns
	# math to find row count based on number of children
	item_grid_bounds.y = ceili(float(itemGrid.get_child_count())/float(itemGrid.columns))
	print(item_grid_bounds)









