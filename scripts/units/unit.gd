extends CharacterBody2D
#region Startup vars

var attributes: CharacterAttributes

var current_move_points: float
var current_action_points: int

var init_pos: Vector2
var action_chart: Array = []
var type: String = 'ally'
var current_distance: float
var target: CharacterBody2D
var active_cursor: Area2D
var movement_speed: float = 200.0


const projectile = preload("res://scenes/entities/projectiles/projectile.tscn")


@onready var hud: CanvasLayer
@onready var game_manager: Node

@onready var navigation_agent = $NavigationAgent2D
@onready var distance_line = $"Distance Line"
@onready var distance_label = %"Distance Label"
@onready var warning_label = %"Warning Label"
@onready var health_label = %"Health Label"
@onready var move_points_label = %"Move Points Label"
@onready var action_points_label = %"Action Points Label"
@onready var sprite = $Sprite
@onready var state_chart = $StateChart
#endregion

#region Startup and resetting
func _ready():
	name = attributes.character_name
	sprite.texture = attributes.combat_texture
	points_reset()
	points_update()
	navigation_agent.path_desired_distance = 2.0
	navigation_agent.target_desired_distance = 2.0

func _process(_delta):
	target = active_cursor.target

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target
	

func _on_game_manager_turn_start():
	points_reset()
	points_update()


func _on_input_event(_viewport, event, _shape_idx):
	if game_manager.turn == 'player':
		if game_manager.selected_unit == null:
			if event.is_action_pressed("left_click"):
				game_manager.selected_unit = self
				init_pos = position
				hud.new_unit()


func points_reset():
	init_pos = position
	current_move_points  = attributes['max_move_distance']
	current_action_points  = attributes['max_action_points']


func points_update():
	health_label.text = 'Current Health: ' + str(attributes['health'])
	move_points_label.text = 'Current Move Points: ' + str(snapped(current_move_points, 0.01))
	action_points_label.text = 'Current Action Points: ' + str(current_action_points)

func distance_toggle(vis):
	distance_label.visible = vis
	warning_label.visible = vis
	distance_line.visible = vis
#endregion

#region Actions
func take_damage(damage):
	attributes['health'] -= damage
	points_update()
	
func move():
	state_chart.send_event('to_idle')
	state_chart.send_event('movement_active')
	current_move_points -= current_distance


func attack():
	if current_action_points - attributes['attack_ap_cost'] >= 0:
		current_action_points -= attributes['attack_ap_cost']
		var new_proj = projectile.instantiate()
		new_proj.target = to_global(distance_line.points[1])
		new_proj.alignment = 'ally'
		new_proj.damage = attributes.attack_damage
		new_proj.game_manager = game_manager
		add_child(new_proj)
	state_chart.send_event('to_idle')


func heal():
	if current_action_points - attributes['heal_ap_cost'] >= 0:
		current_action_points -= attributes['heal_ap_cost']
		if target.type == 'ally' or target.type == 'enemy':
			if target.attributes['health'] + attributes['heal'] <= target.attributes['base_health'] + attributes['max_overheal']:
				target.attributes['health'] += attributes['heal']
			else:
				target.attributes['health'] = target.attributes['base_health'] + attributes['max_overheal']
			target.points_update()
	state_chart.send_event('to_idle')
#endregion

#region StateChart functionality
func distance_check(max_distance):
	current_distance = 0
	distance_line.clear_points()
	#Have to subtract global position to convert coords on global map (I can't remember why to_global() doesn't work
	#Likely, I did something incorrect somewhere else
	distance_line.add_point(init_pos - global_position)
	distance_toggle(true)
	if max_distance == current_move_points:
		set_movement_target(get_global_mouse_position())
		var _next_path_position: Vector2 = navigation_agent.get_next_path_position()
		for point in navigation_agent.get_current_navigation_path():
			distance_line.add_point(point - global_position)
		for i in range(navigation_agent.get_current_navigation_path().size() - 1):
			current_distance += (navigation_agent.get_current_navigation_path()[i].distance_to(navigation_agent.get_current_navigation_path()[i + 1])) / 10
	else:
		distance_line.points = PackedVector2Array([init_pos - global_position, get_global_mouse_position() - global_position])
		current_distance = distance_line.points[0].distance_to(distance_line.points[1]) / 10
	distance_label.text = str(snapped(current_distance, 0.01))
	
	if current_distance >= max_distance:
		state_chart.send_event('too_far')
	else:
		state_chart.send_event('not_too_far')
		
	#Constantly determining validity of event
	#Logic is rather complex for this (or at least very nested); avoid changing if possible
	state_chart.send_event('distance_check_event')


func warning_update(text: String, color: Color, vis: bool):
		warning_label.text = text
		distance_group_modulate(color)
		warning_label.visible = vis


func distance_group_modulate(color):
	var distance_components = get_tree().get_nodes_in_group('Unit Distance Info')
	for component in distance_components:
		component.self_modulate = color

func _on_idle_state_entered():
	distance_toggle(false)
	points_update()

func _on_moving_state_processing(_delta):
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
		for button in hud.actions.get_children():
			if button.name != 'End':
				button.hide()


func _on_valid_event_received(event):
	if has_method(event):
		call(event)
		
		
func _on_movement_active_state_physics_processing(_delta):
	if navigation_agent.is_navigation_finished():
		init_pos = position
		state_chart.send_event('movement_inactive')
		return
		
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	
	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()

func _on_movement_inactive_state_entered():
	state_chart.send_event('to_idle')


func _on_movement_inactive_state_input(event):
	if game_manager.turn == 'player':
		if event.is_action_pressed("right_click"):
			navigation_agent.target_position = Vector2(0, 0)
			state_chart.send_event('to_idle')
			position = init_pos
			distance_toggle(false)
#endregion

#region Targeting
func _on_active_cursor_area_entered(area):
	target = area


func _on_active_cursor_area_exited(_area):
	target = null
#endregion
