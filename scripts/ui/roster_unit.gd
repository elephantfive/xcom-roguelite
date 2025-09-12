extends VBoxContainer
@onready var texture_button = $TextureButton
@onready var label = $Label
@onready var unit_info = %UnitInfo
@export var unit_name: String = ''
var attributes: Dictionary
var selected: bool = false


func _ready():
	update()


func update():
	if unit_name != '':
		attributes = unit_info.character_attributes[unit_name]
		texture_button.texture_normal = load(attributes['texture'])


func _on_texture_button_pressed():
	label.text = ''
	for key in attributes:
		if key != 'unit_actions' and key != 'texture':
			label.text += key.replace('_', ' ').to_upper() + ': ' + str(attributes[key]) + '\n'
