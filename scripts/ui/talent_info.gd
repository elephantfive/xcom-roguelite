extends Node

var talent_trees: Dictionary = {}

func _ready():
	talent_trees['Amigol'] = {
		'Specialization1': [
			'heal',
			'2',
			'3',
			'4',
			'5',
			'6',
		],
		'Specialization2': [
			'cleave',
			'2',
			'3',
			'4',
			'5',
			'6',
		],
		'Specialization3': [
			'placeholder',
			'2',
			'3',
			'4',
			'5',
			'6',
		]
	}
