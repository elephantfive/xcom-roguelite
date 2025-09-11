extends Node
var turn: String
signal turn_start
var selected_unit: Area2D
var current_turn: int = 0
var ally_roster: Array = []
var turns: Array = ['player']
var targets: Array = []
var active_level
@onready var hud = %HUD
@onready var campaign_map = %"Campaign Map"
@onready var end = %End
@onready var unit_holder = %"Unit Holder"
const UNIT = preload("res://entities/units/unit.tscn")

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
	if turns.size() > 0:
		emit_signal("turn_start")

func turn_adv():
	if current_turn + 1 <= len(turns) - 1:
		current_turn += 1
	else:
		current_turn = 0
		end.show()
	turn = turns[current_turn]


func level_adv(level):
	if active_level != null:
		active_level.queue_free()
	active_level = load(level).instantiate()
	get_parent().add_child(active_level)
	targets = []
	for unit in unit_holder.get_children():
		if unit.has_method("_ready"):
			var new_unit = UNIT.instantiate()
			new_unit.attributes = unit.attributes
			new_unit.game_manager = self
			new_unit.hud = hud
			active_level.entities.add_child(new_unit)
			var spawn = randi_range(0, active_level.player_spawns.get_child_count() - 1)
			for child in active_level.player_spawns.get_children():
				if str(spawn) in child.name:
					new_unit.position = child.position
					child.queue_free()
					break
	for entity in active_level.entities.get_children():
		if entity.type == 'ally':
			targets.append(entity)
		else:
			turns.append(str(entity))
	for entity in active_level.entities.get_children():
		if entity.type != 'ally':
			entity.targets = targets
		connect('turn_start', entity._on_game_manager_turn_start)
		entity.game_manager = self
		entity.hud = hud
	campaign_map.hide()
	current_turn = 0
	end.show()
	turn = turns[current_turn]
