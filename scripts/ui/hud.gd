extends CanvasLayer
@onready var game_manager = %"Game Manager"
var selected_unit: Area2D
@onready var move = %Move
@onready var actions = %Actions
@onready var unit_info = %UnitInfo
@onready var unit_roster = %"Unit Roster"


# Unit action buttons have to change on unit select
func new_unit():
	selected_unit = game_manager.selected_unit
	for button in actions.get_children():
		if button.name in selected_unit.attributes['unit_actions']:
			button.show()
			button.text = unit_info.button_text(selected_unit.attributes['name'], button.name)


func _on_move_pressed():
	selected_unit.moving = true


func _on_attack_pressed():
	selected_unit.attacking = true


func _on_end_pressed():
	game_manager.turn_end()
