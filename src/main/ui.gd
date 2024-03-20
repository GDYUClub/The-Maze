class_name UI
extends Control

@onready var textbox:Panel = $Textbox
@onready var bootIcon:Sprite2D =$HUD/BootIcon
signal text_rendered
signal text_removed
signal text_advanced


func render_text(new_text_arr) -> void:
	#loop through the array and display the lines of text
	text_rendered.emit()
	bootIcon.visible = true
	textbox.visible = true
	var textLabel = $Textbox/Text
	#i = 0
	#while i < new_text_arr.length():
	for line in new_text_arr:
		textLabel.text = line
		await text_advanced
	#await text_advanced
	textbox.visible = false
	text_removed.emit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("adv_text"):
		text_advanced.emit()

