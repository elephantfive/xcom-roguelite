extends Node

var talent_trees: Dictionary = {}

func _ready():
	talent_trees['Amigol'] = {
		'Specialization1': [
			'Heal',
			'12',
			'13',
			'14',
			'15',
			'16',
		],
		'Specialization2': [
			'Cleave',
			'22',
			'23',
			'24',
			'25',
			'26',
		],
		'Specialization3': [
			'placeholder',
			'32',
			'33',
			'34',
			'35',
			'36',
		]
	}
