extends Node
var turn: String
signal turn_start
var selected_unit: Area2D
var current_turn: int = 0
#EXTREMELY TEMPORARY
var turns = ["player", "enemy"]
@onready var hud = %HUD

func _ready():
	turn = turns[current_turn]


func turn_end():
	for button in hud.actions.get_children():
		button.hide()
	selected_unit = null
	if current_turn + 1 <= len(turns) - 1:
		current_turn += 1
	else:
		current_turn = 0
	turn = turns[current_turn]
	$TurnTimer.start()

func _on_turn_timer_timeout():
	emit_signal("turn_start")
