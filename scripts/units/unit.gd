extends Area2D
#region Startup vars

var attributes: Dictionary

var current_move_points: float
var current_action_points: int

var init_pos: Vector2
var action_chart: Array = []
var type: String = 'ally'
var current_distance: float
var target: Area2D


const projectile = preload("res://scenes/entities/projectiles/projectile.tscn")
@onready var hud: CanvasLayer
@onready var game_manager: Node

@onready var active_cursor = %ActiveCursor
@onready var distance_line = $"Distance Line"
@onready var distance_label = %"Distance Label"
@onready var warning_label = %"Warning Label"
@onready var health_label = %"Health Label"
@onready var move_points_label = %"Move Points Label"
@onready var action_points_label = %"Action Points Label"
@onready var sprite = %Sprite
@onready var state_chart = $StateChart
#endregion

#region Startup and resetting
func _ready():
	points_reset()
	points_update()


func _process(_delta):
	active_cursor.position = get_viewport().get_mouse_position() - global_position
	if target != null:
		$ActiveCursor/Label.text = 'Target: ' + target.name
	else:
		$ActiveCursor/Label.text = 'No target.'


func _on_game_manager_turn_start():
	points_reset()
	points_update()


func _input(event):
	if game_manager.turn == 'player':
		if game_manager.selected_unit == self:
			if event.is_action_pressed("right_click"):
				state_chart.send_event('to_idle')
				position = init_pos
				get_tree().call_group("Unit Distance Info", "hide")


func _on_input_event(_viewport, event, _shape_idx):
	if game_manager.turn == 'player':
		if game_manager.selected_unit != self:
			if event.is_action_pressed("left_click"):
				game_manager.selected_unit = self
				init_pos = position
				hud.new_unit()
				active_cursor.process_mode = PROCESS_MODE_INHERIT


func points_reset():
	current_move_points  = attributes['max_move_distance']
	current_action_points  = attributes['max_action_points']


func points_update():
	health_label.text = 'Current Health: ' + str(attributes['health'])
	move_points_label.text = 'Current Move Points: ' + str(snapped(current_move_points, 0.01))
	action_points_label.text = 'Current Action Points: ' + str(current_action_points)
#endregion

#region Actions
func take_damage(damage):
	attributes['health'] -= damage
	points_update()
	
func move():
	position = get_viewport().get_mouse_position()
	init_pos = position
	state_chart.send_event('to_idle')
	current_move_points -= current_distance
	points_update()
	get_tree().call_group("Unit Distance Info", "hide")


func attack():
	if current_action_points - attributes['attack_ap_cost'] >= 0:
		current_action_points -= attributes['attack_ap_cost']
		var new_proj = projectile.instantiate()
		new_proj.target = to_global(distance_line.points[1])
		new_proj.alignment = 'ally'
		new_proj.game_manager = game_manager
		add_child(new_proj)
		points_update()
	state_chart.send_event('to_idle')
	get_tree().call_group("Unit Distance Info", "hide")


func heal():
	if current_action_points - attributes['heal_ap_cost'] >= 0:
		#TODO: Implement targeting and, of course, healing
		current_action_points -= attributes['heal_ap_cost']
		points_update()
	state_chart.send_event('to_idle')
#endregion

#region StateChart functionality
func distance_check(max_distance):
	get_tree().call_group("Unit Distance Info", "show")
	distance_line.points = PackedVector2Array([init_pos - global_position, get_viewport().get_mouse_position() - global_position])
	current_distance = distance_line.points[0].distance_to(distance_line.points[1]) / 10
	distance_label.text = str(snapped(current_distance, 0.01))
	
	if current_distance >= max_distance:
		state_chart.send_event('too_far')
	else:
		state_chart.send_event('not_too_far')
		
	state_chart.send_event('distance_check_event')


func warning_update(text: String, color: Color, vis: bool):
		warning_label.text = text
		distance_group_modulate(color)
		warning_label.visible = vis


func distance_group_modulate(color):
	var distance_components = get_tree().get_nodes_in_group('Unit Distance Info')
	for component in distance_components:
		component.self_modulate = color


func _on_moving_state_processing(_delta):
	position = get_viewport().get_mouse_position()
	distance_check(current_move_points)


func _on_attacking_state_processing(_delta):
	distance_check(attributes['max_attack_distance'])


func _on_healing_state_processing(_delta):
	distance_check(attributes['max_heal_distance'])


func _on_moving_state_input(event):
	if event.is_action_pressed("left_click"):
		state_chart.send_event('move')


func _on_attacking_state_input(event):
	if event.is_action_pressed("left_click"):
		state_chart.send_event('attack')


func _on_healing_state_input(event):
	if event.is_action_pressed("left_click"):
		state_chart.send_event('heal')


func _on_idle_state_input(event):
	if event.is_action_pressed('right_click'):
		game_manager.selected_unit = null
		active_cursor.process_mode = PROCESS_MODE_DISABLED
		for button in hud.actions.get_children():
			if button.name != 'End':
				button.hide()


func _on_valid_event_received(event):
	if has_method(event):
		call(event)


func _on_white_state_entered():
	warning_update('', Color(1, 1, 1), false)


func _on_yellow_state_entered():
	warning_update('Blocked!', Color(1, 1, 0), true)


func _on_red_state_entered():
	warning_update('Too far!', Color(1, 0, 0), true)
#endregion

#region Targeting
func _on_active_cursor_area_entered(area):
	target = area


func _on_active_cursor_area_exited(_area):
	target = null
#endregion
