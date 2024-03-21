extends Node2D


var winning_move_sequence: Array[String] = ["down","down","down","down","down"]
var past_5_moves: Array[String] = ["","","","",""]

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	print("BOOTS ON!!!")
	connect_to_player()

func connect_to_player() -> void:
	var parent_player_node = get_node("../")
	# Yeah!! You can get stuff 2 parents up the tree get_node("../../")
	if parent_player_node != self:
		parent_player_node.made_successful_move.connect(Callable(self, "new_move_made"))
	pass

func new_move_made(dir: Vector2) -> void:
	match dir:
		Vector2(0,1):
			note_new_move("down")
			pass
		Vector2(0,-1):
			note_new_move("up")
			pass
		Vector2(1,0):
			note_new_move("right")
			pass
		Vector2(-1,0):
			note_new_move("left")
			pass
	has_player_won()
	pass

func note_new_move(what_direction_string: String) -> void:
	past_5_moves.pop_front()
	past_5_moves.append(what_direction_string)
	pass

func has_player_won() -> void:
	if past_5_moves == winning_move_sequence:
		print("yayay!! You won!")
	pass
