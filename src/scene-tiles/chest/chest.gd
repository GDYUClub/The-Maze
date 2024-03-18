extends Area2D

signal inspected
var opened:bool = false
@onready var sprite = $Sprite2D

#bad solution but not a bad solution YET
@onready var ui:UI = get_parent().get_parent().get_node('UI')

func _init() -> void:
	add_to_group('interact')
	add_to_group('chest')

func _ready() -> void:
	pass

func _on_inspection() -> void:
	if !opened:
		ui.render_text('I warned you about jayden making ui!!!')
		$Sprite2D.frame = 1


