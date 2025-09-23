extends Enemy
	
func attack():
	current_closest_enemy.take_damage(damage)
	game_manager.state_chart.send_event('turn_end')
