extends Area2D
var game_manager: Node
var hud: CanvasLayer
var targets:Array = []
var damage: int = 1
var type: String = 'enemy'
var xp: int = 10000
const projectile = preload("res://scenes/entities/projectiles/projectile.tscn")

# Reading nodes to differentiate units with same names
func _on_game_manager_turn_start():
	if game_manager.turn == str(self):
		var target = targets[randi_range(0, targets.size()-1)]
		var new_proj = projectile.instantiate()
		new_proj.target = target.global_position
		new_proj.alignment = 'enemy'
		new_proj.damage = damage
		new_proj.game_manager = game_manager
		add_child(new_proj)


func take_damage():
	game_manager.turns.erase(str(self))
	if game_manager.turn == str(self):
		game_manager.turn_adv()
	for entity in get_parent().get_children():
		if entity.type == 'ally':
			entity.attributes['xp'] += xp
	queue_free()
