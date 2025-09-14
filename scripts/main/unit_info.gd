extends Node

var character_attributes = {}
var class_attributes = {}
var action_list = {}
var attribute_list = {}

func _ready():
	character_attributes['Amigol'] = {
		'name': 'Amigol',
		'attack_damage': 2,
		'attack_ap_cost': 1,
		'base_health':  20,
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
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'heal': 3,
		'max_overheal': 5,
		'heal_ap_cost': 1,
		'max_heal_distance': 10,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
		}
	character_attributes['Mikael'] = {
		'name': 'Mikael',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
		}
	character_attributes['Mel Dorn'] = {
		'name': 'Mel Dorn',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
		}
	character_attributes['Antwon Dyn'] = {
		'name': 'Antwon Dyn',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
		}
	character_attributes['Xyrinon'] = {
		'name': 'Xyrinon',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
		}
	character_attributes['Vladimir Thrags'] = {
		'name': 'Vladimir Thrags',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
		}
	character_attributes['Vorges LuBo'] = {
		'name': 'Vorges LuBo',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
		}
	character_attributes['Zammel Bladebreaker'] = {
		'name': 'Zammel Bladebreaker',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
		}
	character_attributes['Ruun the Red'] = {
		'name': 'Ruun the Red',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
		}
	character_attributes['Trink Nit'] = {
		'name': 'Trink Nit',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
		}
	character_attributes['Zad Gobum'] = {
		'name': 'Zad Gobum',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
		}
	character_attributes['Maverick Jaeg'] = {
		'name': 'Maverick Jaeg',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
		}
	character_attributes['Shazgoth Urubi'] = {
		'name': 'Shazgoth Urubi',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
		}
	character_attributes['Myeet Snarlfang'] = {
		'name': 'Myeet Snarlfang',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
		}
	
	
	class_attributes['Archer'] = {
		'name': '',
		'specialization': '',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
	}
	class_attributes['Blade'] = {
		'name': '',
		'specialization': '',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
	}
	class_attributes['Wizard'] = {
		'name': '',
		'specialization': '',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
	}
	class_attributes['Priest'] = {
		'name': '',
		'specialization': '',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
	}
	class_attributes['Rogue'] = {
		'name': '',
		'specialization': '',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
	}
	class_attributes['Knight'] = {
		'name': '',
		'specialization': '',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
}
	class_attributes['Enginesmith'] = {
		'name': '',
		'specialization': '',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
	}
	class_attributes['Dark Prophet'] = {
		'name': '',
		'specialization': '',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
	}
	class_attributes['Spellblade'] = {
		'name': '',
		'specialization': '',
		'attack_damage': 1,
		'attack_ap_cost': 1,
		'base_health':  10,
		'max_move_distance':  20,
		'max_attack_distance': 15,
		'max_action_points': 1,
		'unit_actions': ["Attack", 'Move', "Heal"],
		'texture': "res://icon.svg",
	}
	
	action_list['Attack'] = 'Attack an enemy up to %s units away.'
	action_list['Move'] = 'Move up to %s units away.'
	action_list['Heal'] = 'Heal a unit up to %s units away for %s hit points.'
	
	attribute_list['Attack'] = ['max_attack_distance']
	attribute_list['Move'] = ['max_move_distance']
	attribute_list['Heal'] = ['max_heal_distance', 'heal']

func update(old_unit, new_unit):
	character_attributes[old_unit] = new_unit.attributes

func button_text(unit_name, button_name):
	var text_holder = []
	for item in attribute_list[button_name]:
		text_holder.append(str(character_attributes[unit_name][item]))
	return action_list[button_name] % text_holder
