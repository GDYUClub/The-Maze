extends Node


#currently auto-loaded, although I think we could get away with it being a static script, as it dosen't have any instanced values we need to maintain,

const ITEMS = {
    0:{
        "title": "Test Item",
        "icon":"x.png",
        "description":"You shouldn't have this item. If you do, Jayden made a mistake. Yes, there are other devs on this project, but blame all errors on Jayden.",
        "unique":true,
    },
    1:{
        "title": "Another Test Item",
        "icon":"x.png",
        "description":"You (also) shouldn't have this item. If you do, Jayden made a mistake. Yes, there are other devs on this project, but blame all errors on Jayden.",
        "unique":true,
    }
}

# item constructor
func give_item(id:int) -> void:
    var new_item:Item = Item.new()
    new_item.title = ITEMS[id]["title"]
    var icon_name = ITEMS[id]["icon"]
    new_item.icon = load("res://assets/item_icons/" + icon_name)
    new_item.description = ITEMS[id]["description"]
    # add resource to player inventory
    var current_scene = _get_current_scene()
    var player:Player = current_scene.get_node("Player")
    player.inventory.append(new_item)
    print('player now has item: ', new_item)


func _get_current_scene():
    return get_tree().get_root().get_children()[3]


