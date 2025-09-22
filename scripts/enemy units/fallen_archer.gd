extends Enemy

func attack():
	var target = targets[randi_range(0, targets.size()-1)]
	var new_proj = projectile.instantiate()
	new_proj.target = target.global_position
	new_proj.alignment = 'enemy'
	new_proj.damage = damage
	new_proj.game_manager = game_manager
	add_child(new_proj)
