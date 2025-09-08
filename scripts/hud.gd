extends CanvasLayer
@onready var game_manager = %"Game Manager"
var selected_unit: Area2D
@warning_ignore("unused_signal")
signal new_unit
@onready var actions = $CenterContainer/Actions


func _on_new_unit():
	selected_unit = game_manager.selected_unit
	for button in actions.get_children():
		if button.name in selected_unit.unit_actions:
			button.show()
			if button.name == 'Move':
				button.text = 'Move up to ' + str(selected_unit.max_move_distance) + ' units.'
			if button.name == 'Attack':
				button.text = 'Attack an enemy for ' + str(selected_unit.attack_damage) + ' damage.'


func _on_move_pressed():
	selected_unit.init_pos = selected_unit.position
	selected_unit.moving = true


func _on_attack_pressed():
	pass # Replace with function body.


func _on_game_manager_turn_end():
	for button in actions.get_children():
		button.hide()
