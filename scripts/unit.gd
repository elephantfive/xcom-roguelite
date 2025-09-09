extends Area2D

var attack_damage: int = 1
var health: int = 10
var max_move_distance: int = 20
var max_attack_distance: int = 20

var unit_actions = ["Move", "Attack"]


var init_pos: Vector2
var too_far: bool = false
var moving: bool = false
var attacking: bool = false
var type: String = 'ally'
var thru_wall: bool = false

const projectile = preload("res://projectiles/projectile.tscn")
@onready var hud = %HUD
@onready var game_manager = %"Game Manager"
@onready var distance_label = $"Distance Label"
@onready var warning_label = $"Warning Label"
@onready var distance_line = $"Distance Line"
@onready var health_label = $"Health Label"


func _ready():
	health_update()


func _process(_delta):
	if moving:
		position = get_viewport().get_mouse_position()
		distance_check(max_move_distance)
	elif attacking:
		distance_check(max_attack_distance)


func _input(event):
	if game_manager.turn == name:
		if game_manager.selected_unit == self:
			if event.is_action_pressed("right_click"):
				if moving or attacking:
					moving = false
					attacking = false
					position = init_pos
					get_tree().call_group("Unit Distance Info", "hide")
				else:
					game_manager.selected_unit = null
					for button in hud.actions.get_children():
						button.hide()
			elif event.is_action_pressed("left_click"):
				if not too_far:
					if moving:
						if not thru_wall:
							move()
					elif attacking:
						attack()


func _on_input_event(_viewport, event, _shape_idx):
	if game_manager.turn == name:
		if game_manager.selected_unit != self:
			if event.is_action_pressed("left_click"):
				game_manager.selected_unit = self
				init_pos = position
				hud.emit_signal("new_unit")


func health_update():
	health_label.text = 'Current Health: ' + str(health)


func distance_check(max_distance):
	get_tree().call_group("Unit Distance Info", "show")
	distance_line.points = PackedVector2Array([init_pos - global_position, get_viewport().get_mouse_position() - global_position])
	var current_distance = sqrt(((distance_line.points[0].x - distance_line.points[1].x) ** 2) + ((distance_line.points[0].y - distance_line.points[1].y) ** 2)) / 10
	distance_label.text = str(snapped(current_distance, 0.01))
	
	if current_distance >= max_distance:
		too_far = true
		warning_label.show()
		warning_label.text = 'Too far!'
		distance_line.self_modulate = Color(1, 0, 0)
		distance_label.self_modulate = Color(1, 0, 0)
		warning_label.self_modulate = Color(1, 0, 0)
	else:
		too_far = false
		if thru_wall:
			warning_label.show()
			warning_label.text = 'Blocked!'
			distance_line.self_modulate = Color(1, 1, 0)
			distance_label.self_modulate = Color(1, 1, 0)
			warning_label.self_modulate = Color(1, 1, 0)
		else:
			warning_label.hide()
			warning_label.self_modulate = Color(1, 1, 1)
			distance_line.self_modulate = Color(1, 1, 1)
			distance_label.self_modulate = Color(1, 1, 1)


func move():
	position = get_viewport().get_mouse_position()
	moving = false
	game_manager.turn_end()
	get_tree().call_group("Unit Distance Info", "hide")


func attack():
	var new_proj = projectile.instantiate()
	new_proj.target = to_global(distance_line.points[1])
	new_proj.alignment = 'ally'
	new_proj.game_manager = game_manager
	add_child(new_proj)
	attacking = false
	game_manager.turn_end()
	get_tree().call_group("Unit Distance Info", "hide")


func take_damage(damage):
	health -= damage
	health_update()


func _on_distance_line_collision_area_entered(area):
	if area.type == 'wall':
		thru_wall = true


func _on_distance_line_collision_area_exited(area):
	if area.type == 'wall':
		thru_wall = false
