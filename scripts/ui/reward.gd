extends VBoxContainer

var unit_name: String
@export var attributes: CharacterAttributes:
	set(value):
		attributes = value
		texture_button.texture_normal = value.texture
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
		attributes = load("res://resources/ally_stats/characters/" + unit_name + ".tres")
	for property_info in attributes.get_script().get_script_property_list():
				if typeof(attributes.get(property_info.name)) == 2 or typeof(attributes.get(property_info.name)) == 4:
					label.text += property_info.name.replace('_', ' ').to_upper() + ': ' + str(attributes.get(property_info.name)) + '\n'


func _on_texture_button_pressed():
	var new_unit = ROSTER_UNIT.instantiate()
	unit_roster.add_child(new_unit)
	new_unit.game_manager = game_manager
	new_unit.unit_roster = unit_roster
	new_unit.unit_holder = %"Unit Holder"
	new_unit.unit_info = %UnitInfo
	new_unit.attributes = attributes
	for unit in unit_roster.get_children():
		game_manager.state_chart.set_expression_property("xp", unit.attributes.xp)
		game_manager.state_chart.set_expression_property("xp_needed", unit.attributes.xp_needed)
		game_manager.state_chart.send_event('idle')
		break
