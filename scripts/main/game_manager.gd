extends Node

signal turn_start

var turn: String
var selected_unit: Area2D
var current_turn: int = 0
var turns: Array = ['player']
var targets: Array = []
var level_path: String
var active_level
var roster_unit_selected
var squad_unit_selected
var money: int = 0

const UNIT = preload("res://scenes/entities/units/unit.tscn")

@onready var state_chart = $StateChart
@onready var hud = %HUD
@onready var end = %End
@onready var unit_holder = %"Unit Holder"
@onready var level_end_timer = $LevelEndTimer
@onready var rewards = %Rewards
@onready var unit_roster = %"Unit Roster"
@onready var unit_info = %UnitInfo
@onready var active_cursor = %ActiveCursor
@onready var level_up = %"Level Up"
@onready var reward_screen = %"Reward Screen"
@onready var loadout = %Loadout
@onready var shop = %Shop
@onready var tech_tree = %TechTree


func turn_end():
	for button in hud.actions.get_children():
		button.hide()
	selected_unit = null
	if turns.size() > 1:
		turn_adv()
		$TurnTimer.start()
	else:
		end.hide()
		level_end_timer.start()

func _on_turn_timer_timeout():
	emit_signal("turn_start")

func _on_level_end_timer_timeout():
	state_chart.send_event('level_end')
	

func turn_adv():
	if current_turn + 1 <= len(turns) - 1:
		current_turn += 1
	else:
		current_turn = 0
		end.show()
	turn = turns[current_turn]



func toggle(object, process:ProcessMode, vis:bool):
	if typeof(object) == TYPE_STRING:
		var components = get_tree().get_nodes_in_group(object)
		for child in components:
			child.visible = vis
			child.process_mode = process
	else:
		object.visible = vis
		object.process_mode = process


func _on_changing_squad_state_input(event):
	if event.is_action_pressed("right_click"):
		squad_unit_selected = null
		roster_unit_selected = null
		state_chart.send_event('idle')


func _on_idle_state_entered():
	if active_level != null:
		active_level.queue_free()
	toggle("Campaign Menus", PROCESS_MODE_INHERIT, false)
	toggle("Campaign Map", PROCESS_MODE_INHERIT, true)
	for unit in unit_holder.get_children():
		unit.state_chart.send_event('idle')


func _on_idle_state_exited():
	toggle("Campaign Menus", PROCESS_MODE_DISABLED, false)
	toggle("Campaign Map", PROCESS_MODE_DISABLED, false)


func _on_changing_squad_state_entered():
	toggle("Campaign Map", PROCESS_MODE_INHERIT, true)
	for unit in unit_holder.get_children():
		unit.state_chart.send_event('squad_change')


func _on_level_end_taken():
	active_cursor.hide()
	active_cursor.process_mode = PROCESS_MODE_DISABLED
	
	#for entity in active_level.entities.get_children():
		#for unit in unit_info.character_attributes:
			#if entity.type == 'ally':
				#if entity.attributes['name'] == unit_info.character_attributes[unit]['name']:
					#unit_info.update(entity.attributes['name'], entity)

	#for unit in unit_holder.get_children():
		#unit.update()
	#for unit in unit_roster.get_children():
		#unit.update()
		
	for i in range(0, active_level.random_rewards.size()):
		rewards.get_children()[i].unit_name = active_level.random_rewards[i]
		rewards.get_children()[i].update()
		
	
	state_chart.send_event('reward')


func _on_in_level_state_entered():
	active_cursor.process_mode = PROCESS_MODE_INHERIT
	active_cursor.show()
	
	active_level = load(level_path).instantiate()
	get_parent().add_child(active_level)
	
	targets = []
	
	for unit in unit_holder.get_children():
		if unit.attributes != null:
			var new_unit = UNIT.instantiate()
			new_unit.attributes = unit.attributes
			new_unit.name = new_unit.attributes.character_name
			new_unit.game_manager = self
			new_unit.active_cursor = active_cursor
			new_unit.hud = hud
			active_level.entities.add_child(new_unit)
			for child in active_level.player_spawns.get_children():
				new_unit.position = child.position
				new_unit.init_pos = child.position
				child.free()
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
		
	current_turn = 0
	end.show()
	turn = turns[current_turn]


func _on_reward_state_entered():
	toggle(reward_screen, PROCESS_MODE_INHERIT, true)


func _on_level_up_state_entered():
	toggle("Campaign Menus", PROCESS_MODE_DISABLED, false)
	toggle(level_up, PROCESS_MODE_INHERIT, true)


func _on_shop_pressed():
	state_chart.send_event('shop')


func _on_shop_state_entered():
	toggle(shop, PROCESS_MODE_INHERIT, true)


func _on_tech_tree_pressed():
	state_chart.send_event('tech')


func _on_tech_tree_state_entered():
	toggle(tech_tree, PROCESS_MODE_INHERIT, true)
