extends Area2D
var highlighted: bool = false
var attack_damage: int = 1
var max_move_distance: int = 20
var init_pos: Vector2
var too_far: bool = false
var unit_actions = ["Move", "Attack"]
var moving: bool = false
@onready var hud = %HUD
@onready var game_manager = %"Game Manager"
@onready var distance_label = $"Distance Label"
@onready var warning_label = $"Warning Label"
@onready var distance_line = $"Distance Line"
@onready var health_label = $"Health Label"

func _process(_delta):
	if moving:
		distance_line.points = PackedVector2Array([init_pos - global_position, position - global_position])
		get_tree().call_group("Unit Distance Info", "show")
		var current_distance = sqrt(((init_pos.x - position.x) ** 2) + ((init_pos.y - position.y) ** 2)) / 10
		distance_label.text = str(snapped(current_distance, 0.01))
		if current_distance >= max_move_distance:
			too_far = true
			warning_label.show()
			distance_label.self_modulate = Color(1, 0, 0)
		else:
			too_far = false
			warning_label.hide()
			distance_label.self_modulate = Color(1, 1, 1)
		position = get_viewport().get_mouse_position()


func _on_input_event(_viewport, event, _shape_idx):
	if game_manager.turn == "player":
		if highlighted:
			if event.is_action_pressed("left_click"):
				if game_manager.selected_unit != self:
					game_manager.selected_unit = self
					hud.emit_signal("new_unit")
				else:
					if moving:
						if not too_far:
							moving = false
							game_manager.emit_signal("turn_end")
							get_tree().call_group("Unit Distance Info", "hide")
			#if event.is_action_pressed("right_click"):
				#position = init_pos
				#selected = false
				#get_tree().call_group("Unit Distance Info", "hide")


func _on_mouse_entered():
	highlighted = true


func _on_mouse_exited():
	highlighted = false
