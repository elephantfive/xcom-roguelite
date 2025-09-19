extends VBoxContainer

@onready var texture_button = $TextureButton
@onready var label = $Label

@export var attributes: CharacterAttributes:
	set(value):
		attributes = value
		texture_button.texture_normal = value.texture

@onready var state_chart = $StateChart
@onready var add_to_squad = $AddToSquad

var unit_info
var unit_holder
var game_manager
var unit_roster


func _on_texture_button_pressed():
	state_chart.send_event('pressed')
	game_manager.state_chart.send_event('squad_changed')
	
	for unit in unit_roster.get_children():
		if unit.attributes != attributes:
			unit.label.text = ''
			unit.add_to_squad.hide()
		
	if label.text == '':
		for key in attributes:
			if key != 'unit_actions' and key != 'texture':
				label.text += key.replace('_', ' ').to_upper() + ': ' + str(attributes[key]) + '\n'
	else:
		add_to_squad.hide()
		label.text = ''

func _on_add_to_squad_pressed():
	game_manager.state_chart.send_event('squad_change')
	
	for unit in unit_holder.get_children():
		unit.label.text = ''
		unit.remove_from_squad.hide()
		
	for unit in unit_roster.get_children():
		unit.label.text = ''
		unit.add_to_squad.hide()
		
	game_manager.squad_unit_selected = null
	game_manager.roster_unit_selected = self


func _on_on_squad_event_received(event):
	if event == 'pressed':
		add_to_squad.hide()


func _on_off_squad_event_received(event):
	if event == 'pressed':
		add_to_squad.show()
		for unit in unit_holder.get_children():
			if unit.attributes == attributes:
				state_chart.send_event('on_squad')
				add_to_squad.hide()
