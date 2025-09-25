extends Area2D

var moving: bool = false
var max_move_distance: int = 20
var current_move_points: float = max_move_distance
var too_far: bool = false
var current_distance: float

@onready var map_movement_line = $"../Map Movement Line"
@onready var distance_label = $"Distance Label"
@onready var warning_label = $"Warning Label"
@onready var cooldown = $Cooldown


func points_reset():
	current_move_points = max_move_distance

func _process(_delta):
	if moving:
		map_movement_line.points[1] = get_global_mouse_position()
		distance_check(current_move_points)


func _on_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed('left_click'):
		if not moving and cooldown.time_left == 0:
			map_movement_line.points[0] = position
			moving = true

func _input(event):
	if event.is_action_pressed('left_click'):
		if moving and not too_far:
			current_move_points -= current_distance
			position = get_global_mouse_position()
			moving = false
			get_tree().call_group("Unit Distance Info", "hide")
			cooldown.start()
			
	if event.is_action_pressed('right_click'):
		if moving:
			moving = false
			get_tree().call_group("Unit Distance Info", "hide")


func distance_check(max_distance):
	get_tree().call_group("Unit Distance Info", "show")
	current_distance = map_movement_line.points[0].distance_to(map_movement_line.points[1]) / 10
	distance_label.text = str(snapped(current_distance, 0.01))
	
	if current_distance >= max_distance:
		too_far = true
		warning_label.show()
		warning_label.text = 'Too far!'
		map_movement_line.self_modulate = Color(1, 0, 0)
		distance_label.self_modulate = Color(1, 0, 0)
		warning_label.self_modulate = Color(1, 0, 0)
	else:
		too_far = false
		warning_label.hide()
		warning_label.self_modulate = Color(1, 1, 1)
		map_movement_line.self_modulate = Color(1, 1, 1)
		distance_label.self_modulate = Color(1, 1, 1)


func _on_map_end_pressed():
	points_reset()
