extends TextureButton
@onready var unit_info = %UnitInfo
@onready var label = $"../../UnitDesc/Label"
@export var unit_name: String
var attributes: Dictionary
@onready var unit_roster = %"Unit Roster"
@onready var game_manager = %"Game Manager"
@onready var unit_holder = %"Unit Holder"
@onready var remove_from_squad = $"../../UnitDesc/RemoveFromSquad"
@onready var state_chart = $StateChart


func _ready():
	update()

func _on_pressed():
	state_chart.send_event('pressed')


func update():
	if unit_name != '':
		self_modulate = Color(1, 1, 1)
		attributes = unit_info.character_attributes[unit_name]
		texture_normal = load(attributes['texture'])
	else:
		remove_from_squad.hide()
		attributes = {}
		self_modulate = Color(.25, .25, .25)


func _on_remove_from_squad_pressed():
	if game_manager.squad_unit_selected == self:
		for unit in unit_roster.get_children():
			if unit.unit_name == unit_name:
				unit.state_chart.send_event('off_squad')
		game_manager.squad_unit_selected = null
		unit_name = ''
		label.text = ''
		update()


func _on_idle_event_received(event):
	if event == 'pressed':
		if unit_name != '':
			remove_from_squad.show()
		label.text = ''
		if game_manager.squad_unit_selected != self:
			game_manager.squad_unit_selected = self
			for key in attributes:
				if key != 'unit_actions' and key != 'texture':
					label.text += key.replace('_', ' ').to_upper() + ': ' + str(attributes[key]) + '\n'
		else:
			remove_from_squad.hide()
			game_manager.squad_unit_selected = null


func _on_changing_squad_event_received(event):
	if event == 'pressed':
		var valid = true
		for unit in unit_holder.get_children():
			if unit.unit_name == game_manager.roster_unit_selected.unit_name:
				game_manager.roster_unit_selected = null
				game_manager.state_chart.send_event('idle')
				valid = false
				break
		if valid:
			for unit in unit_roster.get_children():
				if unit.unit_name == unit_name:
					unit.state_chart.send_event('off_squad')
			unit_name = game_manager.roster_unit_selected.unit_name
			game_manager.roster_unit_selected.add_to_squad.hide()
			game_manager.roster_unit_selected.update()
			game_manager.roster_unit_selected.state_chart.send_event('on_squad')
			game_manager.roster_unit_selected = null
			game_manager.squad_unit_selected = null
			game_manager.state_chart.send_event('idle')
			update()
