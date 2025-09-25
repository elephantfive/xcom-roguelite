extends Camera2D
@onready var state_chart = $StateChart
var last_mouse_pos: Vector2
var zoom_step = 1.1

func _input(event):
	#Thanks to Godot forum users Dodolta & Ulukanovich. No idea why this was so hard for me
	if event is InputEventMouseButton:
		if event.is_pressed():
			last_mouse_pos = get_viewport().get_mouse_position()
			if event.button_index == MOUSE_BUTTON_WHEEL_UP and zoom.x > 0.25 and zoom.y > 0.25:
				set_zoom(zoom - Vector2(0.25, 0.25))
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				set_zoom(zoom + Vector2(0.25, 0.25))


			if event.button_index == MOUSE_BUTTON_MIDDLE:
				state_chart.send_event('moving')
		if event.is_released():
			if event.button_index == MOUSE_BUTTON_MIDDLE:
				state_chart.send_event('not_moving')


func _on_moving_state_physics_processing(_delta):
	if last_mouse_pos != get_viewport().get_mouse_position():
		var mouse_transform = get_viewport().get_mouse_position() - last_mouse_pos
		last_mouse_pos = get_viewport().get_mouse_position()
		position -= mouse_transform * 2
