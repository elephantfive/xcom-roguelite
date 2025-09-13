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
	if area.type == "enemy":
		if alignment == 'ally':
			area.take_damage()
			queue_free()
	elif area.type == "ally":
		if alignment == 'enemy':
			area.take_damage(damage)
			hide()
			turn_timer.start()
	elif area.type == "wall":
		if alignment == 'enemy':
			hide()
			target = position
			turn_timer.start()
		else:
			queue_free()
		


func _on_turn_timer_timeout():
	game_manager.turn_end()
	queue_free()
