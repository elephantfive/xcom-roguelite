extends Node

var talent_trees: Dictionary = {}

func _ready():
	talent_trees['Amigol'] = {
		'Specialization1': [
			['Heal', 'Smite'],
			[],
			['Mass Heal', 'Banish'],
			[],
			['Resurrection', 'Empower'],
			[],
			['Mass Ressurection', 'Sanctify'],
			[],
		],
		'Specialization2': [
			['Fortify', 'Swift Strike'],
			[],
			['Taunt', 'Sprint'],
			[],
			['Blockade', 'Blade Dance'],
			[],
			[],
			[],
		],
		'Specialization3': [
			['Firebolt', 'Counterspell'],
			[],
			['Fireball', 'Arcane Barrier'],
			[],
			['Summon Demon', 'Polymorph'],
			[],
			['Drain Life', 'Arcane4'],
			[],
		]
	}
