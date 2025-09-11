extends CanvasLayer
@onready var game_manager = %"Game Manager"
var selected_unit: Area2D
@warning_ignore("unused_signal")
signal new_unit
@onready var actions = $ActionBox/Actions
@onready var move = %Move


func _on_new_unit():
	selected_unit = game_manager.selected_unit
	move.show()
	move.text = 'Move up to ' + str(selected_unit.attributes['max_move_distance']) + ' units.'
	for button in actions.get_children():
		if button.name in selected_unit.attributes['unit_actions']:
			button.show()
			if button.name == 'Attack':
				button.text = 'Attack an enemy for ' + str(selected_unit.attributes['attack_damage']) + ' damage.'


func _on_move_pressed():
	selected_unit.moving = true


func _on_attack_pressed():
	selected_unit.attacking = true


func _on_end_pressed():
	game_manager.turn_end()
