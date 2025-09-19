extends Node

var action_list = {}
var attribute_list = {}

func _ready():
	action_list['Attack'] = 'Attack an enemy up to %s units away.'
	action_list['Move'] = 'Move up to %s units away.'
	action_list['Heal'] = 'Heal a unit up to %s units away for %s hit points.'
	
	attribute_list['Attack'] = ['max_attack_distance']
	attribute_list['Move'] = ['max_move_distance']
	attribute_list['Heal'] = ['max_heal_distance', 'heal']
	

func button_text(unit, button_name):
	var text_holder = []
	for item in attribute_list[button_name]:
		text_holder.append(str(unit.attributes.get(item)))
	return action_list[button_name] % text_holder
