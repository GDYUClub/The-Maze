class_name Item
extends Resource

@export var icon:Texture
@export var id:String
@export var title:String
@export var description:String
var in_inventory = false

func given_to_player():
	in_inventory = true

func removed_from_player():
	in_inventory = false
