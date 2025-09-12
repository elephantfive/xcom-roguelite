extends TextureButton
@onready var unit_info = %UnitInfo
@onready var label = $"../../UnitDesc/Label"
@export var unit_name: String = ''
var attributes: Dictionary
@onready var unit_roster = %"Unit Roster"


func _ready():
	update()


func _on_pressed():
	label.text = ''
	for key in attributes:
		if key != 'unit_actions' and key != 'texture':
			label.text += key.replace('_', ' ').to_upper() + ': ' + str(attributes[key]) + '\n'
			
func update():
	if unit_name != '':
		for unit in unit_roster.get_children():
			if unit.unit_name != '' and unit.selected == false:
				unit.selected = true
				unit_name = unit.unit_name
				attributes = unit_info.character_attributes[unit_name]
				texture_normal = load(attributes['texture'])
