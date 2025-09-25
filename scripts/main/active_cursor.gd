extends Area2D
@onready var label = $Label
var target: CharacterBody2D

func _process(_delta):
	global_position = get_global_mouse_position()
	if target != null:
		label.text = 'Target: ' + target.name
	else:
		label.text = 'No target.'


func _on_body_entered(body):
	target = body


func _on_body_exited(_body):
	target = null
