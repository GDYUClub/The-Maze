
extends Node


#currently auto-loaded, although I think we could get away with it being a static script, as it dosen't have any instanced values we need to maintain,


const ITEMS = {
    0:{
        "id_name":"test_item",
        "title": "Test Item",
        "icon":"x.png",
        "description":"You shouldn't have this item. If you do, Jayden made a mistake. Yes, there are other devs on this project, but blame all errors on Jayden.",
        "unique":true,
    },
    1:{
        "name":"test_item1",
        "title": "Another Test Item",
        "icon":"x.png",
        "description":"You (also) shouldn't have this item. If you do, Jayden made a mistake. Yes, there are other devs on this project, but blame all errors on Jayden.",
        "unique":true,
    }
}

# item constructor
func give_item(id:int) -> void:
    var new_item:Item = Item.new()
    new_item.id_name = ITEMS[id]["name"]
    new_item.title = ITEMS[id]["title"]
    new_item.icon = ITEMS[id]["icon"]
    new_item.description = ITEMS[id]["description"]
    # add resource to player inventory

