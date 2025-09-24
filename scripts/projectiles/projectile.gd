extends Area2D

var target: Vector2
var speed: float = 1000
var type: String = 'proj'
var alignment: String
var damage: int
var game_manager: Node
@onready var turn_timer = $TurnTimer

func _process(delta):
	if alignment == 'ally' and global_position == target:
		queue_free()
	if target != null:
		global_position = global_position.move_toward(target, speed * delta)


func _on_area_entered(area):
	if area.type == "wall":
		if alignment == 'enemy':
			hide()
			target = position
			turn_timer.start()
		else:
			queue_free()
		


func _on_turn_timer_timeout():
	if alignment == 'enemy':
		game_manager.state_chart.send_event('turn_end')
	queue_free()


func _on_body_entered(body):
	if body.type == "enemy" and alignment == 'ally':
		body.take_damage(damage)
		queue_free()
	elif body.type == "ally" and alignment == 'enemy':
		body.take_damage(damage)
		hide()
		turn_timer.start()
