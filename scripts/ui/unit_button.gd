extends TextureButton
@onready var label = $"../../UnitDesc/Label"
@export var attributes: CharacterAttributes:
	set(value):
		attributes = value
		texture_normal = value.texture
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
	if attributes != null:
		self_modulate = Color(1, 1, 1)
	else:
		remove_from_squad.hide()
		self_modulate = Color(.25, .25, .25)



func _on_remove_from_squad_pressed():
	if game_manager.squad_unit_selected == self:
		for unit in unit_roster.get_children():
			if unit.attributes == attributes:
				unit.state_chart.send_event('off_squad')
		game_manager.squad_unit_selected = null
		attributes = null
		label.text = ''
		update()


func _on_idle_event_received(event):
	if event == 'pressed':
		if attributes != null:
			remove_from_squad.show()
		label.text = ''
		if game_manager.squad_unit_selected != self:
			game_manager.squad_unit_selected = self
			for property_info in attributes.get_script().get_script_property_list():
				if typeof(attributes.get(property_info.name)) == 2 or typeof(attributes.get(property_info.name)) == 4:
					label.text += property_info.name.replace('_', ' ').to_upper() + ': ' + str(attributes.get(property_info.name)) + '\n'
		else:
			remove_from_squad.hide()
			game_manager.squad_unit_selected = null


func _on_changing_squad_event_received(event):
	if event == 'pressed':
		var valid = true
		for unit in unit_holder.get_children():
			if unit.attributes == game_manager.roster_unit_selected.attributes:
				game_manager.roster_unit_selected = null
				game_manager.state_chart.send_event('idle')
				valid = false
				break
		if valid:
			for unit in unit_roster.get_children():
				if unit.attributes == attributes:
					unit.state_chart.send_event('off_squad')
			attributes = game_manager.roster_unit_selected.attributes
			game_manager.roster_unit_selected.add_to_squad.hide()
			game_manager.roster_unit_selected.state_chart.send_event('on_squad')
			game_manager.roster_unit_selected = null
			game_manager.squad_unit_selected = null
			game_manager.state_chart.send_event('idle')
			update()
