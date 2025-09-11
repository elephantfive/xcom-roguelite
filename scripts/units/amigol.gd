extends TextureButton
@onready var unit_info = %UnitInfo
@onready var label = $"../../UnitDesc/Label"
@export var unit_name: String
var attributes: Dictionary


func _ready():
	attributes = unit_info.character_attributes[unit_name]
	texture_normal = load(attributes['texture'])


func _on_pressed():
	label.text = ''
	for key in attributes:
		if key != 'unit_actions' and key != 'texture':
			label.text += key.replace('_', ' ').to_upper() + ': ' + str(attributes[key]) + '\n'
