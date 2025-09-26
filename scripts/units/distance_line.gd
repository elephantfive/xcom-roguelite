extends Line2D
@onready var collision_shape = $"Distance Line Collision/CollisionShape2D"


#func _process(_delta):
	#collision_shape.shape.a = points[0]
	#collision_shape.shape.b = points[1]


func _on_white_state_entered():
	get_parent().warning_update('', Color(1, 1, 1), false)


func _on_yellow_state_entered():
	get_parent().warning_update('Blocked!', Color(1, 1, 0), true)


func _on_red_state_entered():
	get_parent().warning_update('Too far!', Color(1, 0, 0), true)
	

func _on_distance_line_collision_area_entered(area):
	if area.type == 'wall':
		get_parent().state_chart.send_event('thru_wall')
	elif (area.type == 'ally' or area.type == 'enemy') and area != get_parent():
		get_parent().state_chart.send_event('thru_ally')


func _on_distance_line_collision_area_exited(area):
	if area.type == 'wall':
		get_parent().state_chart.send_event('not_thru_wall')
	elif (area.type == 'ally' or area.type == 'enemy') and area != get_parent():
		get_parent().state_chart.send_event('not_thru_ally')
