extends TextureButton
@onready var unit_info = %UnitInfo
@onready var label = $"../../UnitDesc/Label"
@export var unit_name: String = ''
var attributes: Dictionary
@onready var unit_roster = %"Unit Roster"
var selected: bool = false


func _ready():
	update()


func _on_pressed():
	label.text = ''
	if not selected:
		selected = true
		for key in attributes:
			if key != 'unit_actions' and key != 'texture':
				label.text += key.replace('_', ' ').to_upper() + ': ' + str(attributes[key]) + '\n'
	else:
		selected = false
		label.text = ''
			
func update():
	if unit_name != '':
		for unit in unit_roster.get_children():
			if unit.unit_name != '' and unit.on_squad == false:
				unit.on_squad = true
				unit_name = unit.unit_name
				attributes = unit_info.character_attributes[unit_name]
				texture_normal = load(attributes['texture'])
