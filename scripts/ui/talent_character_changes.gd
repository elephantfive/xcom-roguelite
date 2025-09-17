extends Node

var unit_info: Node
var selected_unit
var talent_dict = {
	'Priest21': {
		'max_move_distance': 15
	}
}

func add_talent(talent):
	if talent in unit_info.action_list:
		unit_info.character_attributes[selected_unit]['unit_actions'].append(talent)
	elif talent in talent_dict:
		for stat in talent_dict[talent]:
			unit_info.character_attributes[selected_unit][stat] += talent_dict[talent][stat]
