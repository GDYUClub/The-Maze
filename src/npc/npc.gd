extends Area2D

@export var dialogue_array: Array[String] = []
@export var is_cow: bool = true

@export var dialog_resource: DialogueResource
@export var dialog_start: String = "start"

# Should this go into a singleton?
const dialogBox = preload("res://assets/dialogue_boxes/balloon.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("npc")
	if !is_cow:
		self.get_node("Sprite2D").region_rect = Rect2(288,144,16,16)
	else:
		self.get_node("Sprite2D").region_rect = Rect2(432,112,16,16)
	pass # Replace with function body.

func npc_interaction() -> void:
	print("MOOOOOOOOOOO")
	var balloon: Node = dialogBox.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialog_resource,dialog_start)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
