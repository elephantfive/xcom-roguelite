extends TextureButton
var talent: String
var selected_unit
var unit_info: Node

func _on_pressed():
	if unit_info.character_attributes[selected_unit]['talent_points'] > 0 and talent not in unit_info.character_attributes[selected_unit]['talents']:
		unit_info.character_attributes[selected_unit]['talents'].append(talent)
		unit_info.character_attributes[selected_unit]['talent_points'] -= 1
		self_modulate = Color(.25, .25, .25)
	print(str(unit_info.character_attributes[selected_unit]['talents']))
	print(str(unit_info.character_attributes[selected_unit]['talent_points']))
	
	
