extends Node2D


var move_code: Array[String] = ["down","down","down","down","down"]
var recent_moves: Array[String] = ["","","","",""]

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	print("BOOTS ON!!!")
	connect_to_player()

func connect_to_player() -> void:
	var player := get_parent()
	player.moved.connect(player_moved)

func player_moved(dir: Vector2) -> void:
	match dir:
		Vector2(0,1):
			push_move("down")
			pass
		Vector2(0,-1):
			push_move("up")
			pass
		Vector2(1,0):
			push_move("right")
			pass
		Vector2(-1,0):
			push_move("left")
			pass

	if recent_moves == move_code:
		code_entered()

func push_move(dir_string: String) -> void:
	recent_moves.pop_front()
	recent_moves.append(dir_string)

func code_entered():
		print("yayay!! You won!")
