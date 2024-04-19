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
    }
}

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


