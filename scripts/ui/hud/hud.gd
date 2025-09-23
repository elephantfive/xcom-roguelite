extends CanvasLayer
@onready var game_manager = %"Game Manager"
var selected_unit: CharacterBody2D
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
			button.text = unit_info.button_text(selected_unit, button.name)
		elif button.name != 'End':
			button.hide()


func _on_move_pressed():
	selected_unit.state_chart.send_event('moving')


func _on_attack_pressed():
	selected_unit.state_chart.send_event('attacking')


func _on_end_pressed():
	game_manager.state_chart.send_event('turn_end')


func _on_heal_pressed():
	selected_unit.state_chart.send_event('healing')
