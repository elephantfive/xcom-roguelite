extends Enemy
	
func attack():
	current_closest_enemy.take_damage(damage)
