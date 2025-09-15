extends TextureButton
var talent: String
var selected_unit
var unit_info: Node

func _on_pressed():
	unit_info.character_attributes[selected_unit]['talents'].append(talent)
	
