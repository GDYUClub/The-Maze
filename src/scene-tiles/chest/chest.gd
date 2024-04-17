extends Area2D

signal inspected

@export var dialog_resource: DialogueResource
@export var dialog_start: String = "start"

# Should this go into a singleton?
const dialogBox = preload("res://assets/dialogue_boxes/balloon.tscn")

var opened:bool = false
@onready var sprite = $Sprite2D

#bad solution but not a bad solution YET
@onready var ui:UI = get_parent().get_parent().get_node('UI')

func _init() -> void:
	add_to_group('interact')
	add_to_group('chest')

func _ready() -> void:
	pass

func _on_interaction(player:Player) -> void:
	if dialog_resource == null:
		# we need 404.dialog lol
		return

	#if opened:
		#return

	opened = true
	var balloon: Node = dialogBox.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialog_resource,dialog_start)
	$Sprite2D.frame = 1


