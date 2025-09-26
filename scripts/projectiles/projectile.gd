extends Area2D

var target: Vector2
var speed: float = 1000
var type: String = 'proj'
var alignment: String
var damage: int
var game_manager: Node

func _process(delta):
	if alignment == 'ally' and global_position == target:
		queue_free()
	if target != null:
		global_position = global_position.move_toward(target, speed * delta)


func _on_area_entered(area):
	if area.type == "wall":
		queue_free()


func _on_body_entered(body):
	if body.get('type') != null:
		if body.type == "enemy" and alignment == 'ally':
			body.take_damage(damage)
			queue_free()
		elif body.type == "ally" and alignment == 'enemy':
			body.take_damage(damage)
			queue_free()
	else:
		var collided_tile: TileData = body.get_cell_tile_data(body.local_to_map(global_position))
		if collided_tile.get_custom_data('type') == 'wall':
			queue_free()
		
