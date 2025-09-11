extends CanvasLayer
@onready var game_manager = %"Game Manager"
var selected_unit: Area2D
@onready var move = %Move
@onready var actions = %Actions


# Unit action buttons have to change on unit select
func new_unit():
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
