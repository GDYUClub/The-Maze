class_name UI
extends Control

@onready var textbox:Panel = $Textbox

func render_text(new_text):
	textbox.visible = true
	var textLabel = $Textbox/Text
	textLabel.text = new_text
	pass
