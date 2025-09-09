extends Area2D

var target: Vector2
var lerp_t: float = 0.0
var speed: float = 2.5
var offset: Vector2 = Vector2(5,5)
var type: String = 'proj'

func _process(delta):
	lerp_t += delta * speed
	if target != null:
		position = position.lerp(target, lerp_t)
	if position >= target - offset:
		queue_free()
