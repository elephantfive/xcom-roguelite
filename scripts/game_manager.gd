extends Node
var turn: String
signal turn_start
var selected_unit: Area2D
var current_turn: int = 0
var turns: Array = []
var targets: Array = []
@onready var hud = %HUD
@onready var active_level = $"../Active Level"

func _ready():
	for child in active_level.get_children():
		if child.name == 'Entities':
			for entity in child.get_children():
				if entity.type == 'ally':
					targets.append(entity)
				connect('turn_start', entity._on_game_manager_turn_start)
				entity.game_manager = self
				entity.hud = hud
				turns.append(entity.name)
	turn = turns[current_turn]


func turn_end():
	for button in hud.actions.get_children():
		button.hide()
	selected_unit = null
	turn_adv()
	$TurnTimer.start()

func _on_turn_timer_timeout():
	if 'Enemy' in turns:
		emit_signal("turn_start")
	else:
		turn = 'win'
		print("You win!")

func turn_adv():
	if current_turn + 1 <= len(turns) - 1:
		current_turn += 1
	else:
		current_turn = 0
	turn = turns[current_turn]
