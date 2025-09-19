extends Node

var unit_info: Node
var selected_unit

func add_talent(talent):
	if talent in unit_info.action_list:
		unit_info.character_attributes[selected_unit]['unit_actions'].append(talent.name)
	#elif has_method(talent):
		#call(talent)
