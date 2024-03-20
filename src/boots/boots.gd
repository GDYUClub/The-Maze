extends Node2D


var sequence_to_reach_golden_piece: Array[String] = ["down","down","down","down","down"]
var past_moves_relevant_to_code: Array[String] = ["","","","",""]

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	print("BOOTS ON!!!")
	connect_move_signal_to_player()

func connect_move_signal_to_player() -> void:
	var parent_player_node = get_node("../")
	# Yeah!! You can get stuff 2 parents up the tree get_node("../../")
	if parent_player_node != self:
		parent_player_node.made_successful_move.connect(Callable(self, "new_move_made"))
	pass

func new_move_made(what_direction) -> void:
	match what_direction:
		Vector2(0,1):
			add_most_recent_move("down")
			pass
		Vector2(0,-1):
			add_most_recent_move("up")
			pass
		Vector2(1,0):
			add_most_recent_move("right")
			pass
		Vector2(-1,0):
			add_most_recent_move("left")
			pass
	check_if_full_code_was_put()
	pass

func add_most_recent_move(what_direction_string: String) -> void:
	past_moves_relevant_to_code.pop_front()
	past_moves_relevant_to_code.append(what_direction_string)
	pass

func check_if_full_code_was_put() -> void:
	if past_moves_relevant_to_code == sequence_to_reach_golden_piece:
		print("yayay!! You won!")
	pass
