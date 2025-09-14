extends Area2D
@onready var label = $Label
var target: Area2D

func _process(_delta):
	position = get_viewport().get_mouse_position()
	if target != null:
		label.text = 'Target: ' + target.name
	else:
		label.text = 'No target.'


func _on_area_entered(area):
	target = area


func _on_area_exited(_area):
	target = null
