extends TextureButton

var unit_name: String
var attributes: Dictionary
@onready var unit_info = %UnitInfo

func update():
	attributes = unit_info.character_attributes[unit_name]
	texture_normal = attributes['texture']
