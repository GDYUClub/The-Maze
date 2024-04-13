class_name Item
extends Resource

var icon:Texture
var id_name:String
var title:String
var description:String
var in_inventory = false

func given_to_player():
	in_inventory = true

func removed_from_player():
	in_inventory = false