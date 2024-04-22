extends Node2D
# help

class Hint:
	var contents: String
	var is_unlocked: bool
	func _init(contents: String) -> void:
		self.contents = contents
		self.is_unlocked = false
	
	func unlock() -> void:
		self.is_unlocked = true

# all hints in game in a nested array
var hints = [[], []]


# level number should be given directly; function handles offsetting for 0-indexing
func add_hint(level: int, content: String) -> void:
	hints[level - 1].append(Hint.new(content))

func all_level_hints_unlocked(level) -> bool:
	var hints_to_check = hints[level - 1].duplicate()
	hints_to_check.reduce(func(hint): return !hint.is_unlocked)
	if hints_to_check.is_empty():
		return true
	else:
		return false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_hint(1, "test")
	#print(hints[0][0].contents)
	#hints.make_read_only()
	#hints[0][0].unlock()
	#print(all_level_hints_unlocked(0))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
