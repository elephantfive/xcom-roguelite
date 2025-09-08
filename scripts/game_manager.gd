extends Node
var turn: String
signal turn_start
signal turn_end
var selected_unit: Area2D
var current_turn: int = 0
#EXTREMELY TEMPORARY
var turns = ["player", "enemy"]

func _ready():
	turn = turns[current_turn]


func _on_turn_end():
	selected_unit = null
	if current_turn + 1 <= len(turns) - 1:
		current_turn += 1
	else:
		current_turn = 0
	turn = turns[current_turn]
	emit_signal("turn_start")
