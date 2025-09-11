extends Node

var character_attributes = {}

func _ready():
	character_attributes['Amigol'] = {
			'name': 'Amigol',
			'attack_damage': 1,
			'health':  10,
			'max_move_distance':  20,
			'max_attack_distance': 20,
			'unit_actions': ["Attack"],
			'texture': "res://icon.svg",
		}
