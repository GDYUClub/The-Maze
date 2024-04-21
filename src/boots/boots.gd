extends Node2D


var winning_move_code: Array[String] = ["down","down","down","down","down","right"]
var teleport_move_code: Array[String] = ["down","up","down","up"]
var recent_moves: Array[String] = ["","","","","",""]

# Called when the node enters the scene tree for the first time.
signal teleport_entered()

func _ready() -> void:
	print("BOOTS ON!!!")
	connect_to_player()
	connect_to_main()


func connect_to_player() -> void:
	var player := get_parent()
	player.moved.connect(player_moved)

func connect_to_main() -> void:
	var main := get_parent().get_parent()
	self.teleport_entered.connect(main.on_teleport_entered)

func player_moved(dir: Vector2) -> void:
	match dir:
		Vector2(0,1):
			push_move("down")
			$DownSound.play()
			pass
		Vector2(0,-1):
			push_move("up")
			$UpSound.play()
			pass
		Vector2(1,0):
			push_move("right")
			$RightSound.play()
			pass
		Vector2(-1,0):
			push_move("left")
			$LeftSound.play()
			pass
	check_move_codes()

func check_move_codes():
	if recent_moves == winning_move_code:
		code_entered()
	if recent_moves.slice(1,-1) == teleport_move_code:
		teleport_entered.emit()
		pass
	pass

func push_move(dir_string: String) -> void:
	recent_moves.pop_front()
	recent_moves.append(dir_string)

func code_entered():
		print("yayay!! You won!")
