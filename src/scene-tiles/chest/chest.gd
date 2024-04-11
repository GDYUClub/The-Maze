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

	DialogueManager.show_example_dialogue_balloon(load("res://src/dialogue/main.dialogue"),"start")
	$Sprite2D.frame = 1

	#if !opened:
		#opened = true

		## we should make a generic chest with the ability to give any item (although we'd need to have some sort of item data strucutre)
		#if !player.has_boots:
			#print('boots')
			#var boots = player.boots_packed_scene.instantiate()
			#player.add_child(boots)
			#player.has_boots = true

			#ui.render_text(['The chest contained boots.',"They fit you perfectly.",'The chest also contained a note:','"SOMEONE ADD SONGBOOT NOISES ALREADY!!!"',"You don't think the note was addressing you."])

		## added a cheeky placeholder if statement for when the player is already wearing boots and opens a new chest
		## did it for shits and giggles
		#elif player.has_boots:
			#print('boots again?')

			#ui.render_text(['The chest contained the same boots.', "The ones you're already wearing.", 'You don\'t need them right now.'])


