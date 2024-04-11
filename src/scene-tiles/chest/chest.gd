extends Area2D

signal inspected

@export var dialog_resource: DialogueResource
@export var dialog_start: String = "start"

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

	if opened:
		return

	opened = true
	DialogueManager.show_example_dialogue_balloon(load("res://src/dialogue/main.dialogue"),"start")
	$Sprite2D.frame = 1


