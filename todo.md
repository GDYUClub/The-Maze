# inventory
## inventory datatype:
- manages an Items Id, icon, description(s), and if the player has it or not? (should they manage that too?)
## inventory screen:
- lets you see all the items you currently have with descriptions of them, pressing action button lets you equip it.
## items in game:
- npcs can check your equipped item and special cutscenes can happen

## format ideas:
### items are all scenes:
- no
### Items are all resources:
- give resources through their url
- would let us manage multiple instances of an item
- maybe the db could act as a master reference, the resource could act as instances?
### item db
- items are all in a big list, give them though id


# todo:
- use grid nodes
- change db to use names instead of numbers
- render items to the game when the menu loads
- fix input issues with canvas layer
- update currently equipped one