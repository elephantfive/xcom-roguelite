extends Area2D

var target: Vector2
var speed: float = 1000
var type: String = 'proj'
var alignment: String
var damage: int
var game_manager: Node

func _process(delta):
	if global_position == target:
		queue_free()
	if target != null:
		global_position = global_position.move_toward(target, speed * delta)


func _on_area_entered(area):
	if area.type == "enemy":
		if alignment == 'ally':
			area.take_damage()
			queue_free()
	elif area.type == "ally":
		if alignment == 'enemy':
			area.take_damage(damage)
			queue_free()
	elif area.type == "wall":
		queue_free()
	
