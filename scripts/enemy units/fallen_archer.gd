extends Enemy

func attack():
	var new_proj = projectile.instantiate()
	new_proj.target = current_closest_enemy.global_position
	new_proj.alignment = 'enemy'
	new_proj.damage = damage
	new_proj.game_manager = game_manager
	add_child(new_proj)
