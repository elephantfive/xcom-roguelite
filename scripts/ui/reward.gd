extends VBoxContainer

var unit_name: String
var attributes: Dictionary
@onready var unit_info = %UnitInfo
@onready var label = $Label
@onready var texture_button = $TextureButton

func update():
	attributes = unit_info.character_attributes[unit_name]
	texture_button.texture_normal = load(attributes['texture'])
	for key in attributes:
		if key != 'unit_actions' and key != 'texture':
			label.text += key.replace('_', ' ').to_upper() + ': ' + str(attributes[key]) + '\n'


func _on_texture_button_pressed():
	get_parent().get_parent().hide()
