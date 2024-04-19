extends CanvasLayer
class_name Menu


@onready var itemDesc:Label = %ItemDesc
@onready var itemTitle:Label = %ItemTitle
@onready var itemGrid:GridContainer = %ItemGrid
@onready var itemCursor:TextureRect = %ItemCursor

@onready var player:Player = get_parent().get_node("Player")
@onready var equippedIcon:TextureRect = get_parent().get_node("HUD/EquippedItem")

var cursor_pos:= Vector2i(0,0)

var item_icon_scene:PackedScene = preload("res://src/menu/item_ui.tscn")

var player_inventory :Array = []
# y = rows x = columns
var item_grid_bounds:= Vector2i(0,0)

func equip_item():
	var current_item_index = cursor_pos.x + (cursor_pos.y * item_grid_bounds.x)
	print("pulled child: ",current_item_index)
	var current_item = itemGrid.get_child(current_item_index)
	player.equipped_item = current_item
	equippedIcon.texture = load("res://assets/item_icons/" +ItemDb.ITEMS[current_item.id]['icon'])
	itemTitle.text = ItemDb.ITEMS[current_item.id]['title']
	itemDesc.text = ItemDb.ITEMS[current_item.id]['description']


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


func _input(event: InputEvent) -> void:
	if visible:
		get_viewport().set_input_as_handled()
		var _input_dir := get_input_vector(event)
		if event.is_action_pressed("ui_accept"):
			equip_item()
		if event.is_action_pressed("menu"):
			visible = false

		if _input_dir != Vector2.ZERO:
			_move_cursor(_input_dir)

func _move_cursor(input_dir) -> void:
	#cursor is 16 + 16 * pos
	#offset is pos - 1 * 8
	if abs(input_dir.x) > 0:
		cursor_pos.x = wrapi(cursor_pos.x + input_dir.x,0,item_grid_bounds.x)
	if abs(input_dir.y) > 0:
		cursor_pos.y = wrapi(cursor_pos.y + input_dir.y,0,item_grid_bounds.y)
	itemCursor.position.x = ((16 + 8) * cursor_pos.x) + 16
	itemCursor.position.y = ((16 + 8) * cursor_pos.y) + 16

	var current_item_index = cursor_pos.x + (cursor_pos.y * item_grid_bounds.x)
	var current_item = itemGrid.get_child(current_item_index)
	itemTitle.text = ItemDb.ITEMS[current_item.id]['title']
	itemDesc.text = ItemDb.ITEMS[current_item.id]['description']





func _load_items(new_inventory:Array) -> void:
	for child in itemGrid.get_children():
		child.queue_free()
	player_inventory = new_inventory
	for item in player_inventory:
		var new_item_icon :TextureRect= item_icon_scene.instantiate()
		# we just store the id of the item in the icon, not the entire resource
		new_item_icon.id = item.id
		new_item_icon.texture = load("res://assets/item_icons/" +ItemDb.ITEMS[item.id]['icon'])
		itemGrid.add_child(new_item_icon)
	item_grid_bounds.x = itemGrid.columns
	# math to find row count based on number of children
	item_grid_bounds.y = ceili(float(itemGrid.get_child_count())/float(itemGrid.columns))
	print("item grid bounds: ", item_grid_bounds)









