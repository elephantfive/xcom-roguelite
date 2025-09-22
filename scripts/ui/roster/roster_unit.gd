extends VBoxContainer

@onready var texture_button = $TextureButton
@onready var label = $Label

@export var attributes: CharacterAttributes:
	set(value):
		attributes = value
		texture_button.texture_normal = value.texture

@onready var state_chart = $StateChart
@onready var add_to_squad = $AddToSquad

var unit_holder
var game_manager
var unit_roster

#func _ready():
	#update.call_deferred()
	#
#func update():
	#if attributes != null:
		#state_chart.send_event.call_deferred('on_squad')

func _on_texture_button_pressed():
	state_chart.send_event('pressed')
	game_manager.state_chart.send_event('idle')
	
	for unit in unit_roster.get_children():
		if unit.attributes != attributes:
			unit.label.text = ''
			unit.add_to_squad.hide()
		
	if label.text == '':
		for property_info in attributes.get_script().get_script_property_list():
				if typeof(attributes.get(property_info.name)) == 2 or typeof(attributes.get(property_info.name)) == 4:
					label.text += property_info.name.replace('_', ' ').to_upper() + ': ' + str(attributes.get(property_info.name)) + '\n'
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
