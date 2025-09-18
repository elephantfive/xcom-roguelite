extends Node

var talent_trees: Dictionary = {}

func _ready():
	for character_class in talent_trees:
		for spec in character_class:
			for talent in spec:
				talent['current_points'] = 0
	talent_trees['Amigol'] = {
		'Specialization1': [
			['Heal', 'Smite'],
			['Priest21', 'Priest22'],
			['Mass Heal', 'Banish'],
			['Priest41', 'Priest42'],
			['Resurrection', 'Empower'],
			['Priest61', 'Pirest62'],
			['Mass Ressurection', 'Sanctify'],
			['Priest81', 'Priest82'],
		],
		'Specialization2': [
			['Fortify', 'Swift Strike'],
			['Blade21', 'Blade22'],
			['Taunt', 'Sprint'],
			['Blade41', 'Blade42'],
			['Blockade', 'Blade Dance'],
			['Blade61', 'Blade62'],
			['Blade71', 'Blade72'],
			['Blade81', 'Blade82'],
		],
		'Specialization3': [
			['Firebolt', 'Counterspell'],
			['Wizard21', 'Wizard22'],
			['Fireball', 'Arcane Barrier'],
			['Wizard41', 'Wizard42'],
			['Summon Demon', 'Polymorph'],
			['Wizard61', 'Wizard62'],
			['Drain Life', 'Arcane4'],
			['Wizard81', 'Wizard82'],
		]
	}
