extends Node


#currently auto-loaded, although I think we could get away with it being a static script, as it dosen't have any instanced values we need to maintain,

const ITEMS = {
	"test0":{
		"title": "TEST ITEM",
		"icon":"sword.png",
		"description":"You shouldn't have this item.",
		"unique":true,
	},
	"test1":{
		"title":"TEST ITEM 2",
		"icon":"pendant.png",
		"description":"You (also) shouldn't have this item.",
		"unique":true,
	},
	"1":{
		"title":"First leap",
		"icon":"pendant.png",
		"description":">September 23 2023 I ask for mechanic ideas after presentations",
		"unique":true,
	},
	"2":{
		"title":"Serious",
		"icon":"pendant.png",
		"description":"No more ideas or potential. Just us coordinating for ourselves",
		"unique":true,
	},
	"3":{
		"title":"Codemaster",
		"icon":"pendant.png",
		"description":"Thank you Jayden for coding this game into existance",
		"unique":true,
	},
	"4":{
		"title":"GDYU",
		"icon":"pendant.png",
		"description":"Shoutout to GDYU",
		"unique":true,
	},
	"5":{
		"title":"Ideas",
		"icon":"pendant.png",
		"description":"Thank you to NDJia, Zohair, Hiking and FaithfulPurpleCap ",
		"unique":true,
	},
	"6":{
		"title":"Bruh",
		"icon":"pendant.png",
		"description":"YWhaaaaa",
		"unique":true,
	},
	"7":{
		"title":"Bruh",
		"icon":"pendant.png",
		"description":"YWhaaaaa",
		"unique":true,
	},
	"8":{
		"title":"Bruh",
		"icon":"pendant.png",
		"description":"YWhaaaaa",
		"unique":true,
	},
	"9":{
		"title":"Bruh",
		"icon":"pendant.png",
		"description":"YWhaaaaa",
		"unique":true,
	},
	"10":{
		"title":"Bruh",
		"icon":"pendant.png",
		"description":"YWhaaaaa",
		"unique":true,
	},
	"11":{
		"title":"Bruh",
		"icon":"pendant.png",
		"description":"YWhaaaaa",
		"unique":true,
	}
}
###ANXT dd all the credit items here

# item constructor
func give_item(id:String) -> void:
	var new_item:Item = Item.new()
	new_item.id = id
	new_item.title = ITEMS[id]["title"]
	var icon_name = ITEMS[id]["icon"]
	new_item.icon = load("res://assets/item_icons/" + icon_name)
	new_item.description = ITEMS[id]["description"]

	# add resource to player inventory
	var current_scene = _get_current_scene()
	var player:Player = current_scene.get_node("Player")
	#if player.has_item(new_item) == false or new_item["unique"] == false:
	player.inventory.append(new_item)
	print('player now has item: ', new_item)


func _get_current_scene():
	return get_tree().get_root().get_children()[-1]


