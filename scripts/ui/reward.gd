extends VBoxContainer

var unit_name: String
var attributes: Dictionary
@onready var unit_info = %UnitInfo
@onready var label = $Label
@onready var texture_button = $TextureButton
@onready var unit_roster = %"Unit Roster"
@onready var campaign_map_hud = %"Campaign Map Hud"
@onready var game_manager = %"Game Manager"

const ROSTER_UNIT = preload("res://scenes/ui/roster_unit.tscn")

func update():
	if unit_name != null:
		label.text = ''
		attributes = unit_info.character_attributes[unit_name]
		texture_button.texture_normal = load(attributes['texture'])
		for key in attributes:
			if key != 'unit_actions' and key != 'texture':
				label.text += key.replace('_', ' ').to_upper() + ': ' + str(attributes[key]) + '\n'


func _on_texture_button_pressed():
	var new_unit = ROSTER_UNIT.instantiate()
	unit_roster.add_child(new_unit)
	new_unit.game_manager = game_manager
	new_unit.unit_roster = unit_roster
	new_unit.unit_holder = %"Unit Holder"
	new_unit.unit_info = %UnitInfo
	new_unit.unit_name = unit_name
	new_unit.update()
	game_manager.state_chart.send_event('idle')
