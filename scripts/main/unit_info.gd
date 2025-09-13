extends Node

var character_attributes = {}
var action_list = {}
var attribute_list = {}

func _ready():
	character_attributes['Amigol'] = {
			'name': 'Amigol',
			'attack_damage': 2,
			'attack_ap_cost': 1,
			'health':  20,
			'max_move_distance':  20,
			'max_attack_distance': 20,
			'max_action_points': 1,
			'unit_actions': ['Attack', 'Move'],
			'texture': "res://icon.svg",
		}
	character_attributes['Nidys'] = {
		'name': 'Nidys',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'heal': 3,
		'heal_ap_cost': 1,
		'max_heal_distance': 10,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
		}
	
	action_list['Attack'] = 'Attack an enemy up to %s units away.'
	action_list['Move'] = 'Move up to %s units away.'
	action_list['Heal'] = 'Heal a unit %s hit points.'
	
	attribute_list['Attack'] = 'max_attack_distance'
	attribute_list['Move'] = 'max_move_distance'
	attribute_list['Heal'] = 'heal'

func update(old_unit, new_unit):
	character_attributes[old_unit] = new_unit.attributes

func button_text(unit_name, button_name):
	return action_list[button_name] % str(character_attributes[unit_name][attribute_list[button_name]])
