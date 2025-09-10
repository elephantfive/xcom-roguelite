extends Node
var turn: String
signal turn_start
var selected_unit: Area2D
var current_turn: int = 0
var turns: Array = []
var targets: Array = []
var active_level
@onready var hud = %HUD
@onready var campaign_map = %"Campaign Map"


func _ready():
	#level_adv("res://scenes/levels/level_1.tscn")
	pass


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
		level_adv("res://scenes/levels/level_2.tscn")

func turn_adv():
	if current_turn + 1 <= len(turns) - 1:
		current_turn += 1
	else:
		current_turn = 0
	turn = turns[current_turn]

func reset():
	targets = []
	for child in active_level.get_children():
		if child.name == 'Entities':
			for entity in child.get_children():
				if entity.type == 'ally':
					targets.append(entity)
				connect('turn_start', entity._on_game_manager_turn_start)
				entity.game_manager = self
				entity.hud = hud
				turns.append(entity.name)
	current_turn = 0
	turn = turns[current_turn]


func level_adv(level):
	if active_level != null:
		active_level.queue_free()
	active_level = load(level).instantiate()
	get_parent().add_child.call_deferred(active_level)
	campaign_map.hide()
	reset()
