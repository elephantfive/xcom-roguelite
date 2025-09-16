extends Control

@onready var tree_container = %TreeContainer
@onready var specialization_1 = %Specialization1
@onready var specialization_2 = %Specialization2
@onready var specialization_3 = %Specialization3
@onready var talent_info = %TalentInfo
@onready var unit_info = %UnitInfo
var current_unit


func _on_level_up_state_entered():
	for unit in unit_info.character_attributes:
		if unit_info.character_attributes[unit].has('xp'):
			if unit_info.character_attributes[unit]['xp'] >= unit_info.character_attributes[unit]['xp_needed']:
				unit_info.character_attributes[unit]['xp'] -= unit_info.character_attributes[unit]['xp_needed']
				unit_info.character_attributes[unit]['talent_points'] += 1
				unit_info.character_attributes[unit]['xp_needed'] *= 2
				for spec in tree_container.get_children():
					for talent_tree in talent_info.talent_trees[unit]:
						if spec.name == talent_tree:
							for i in range(spec.get_child_count()):
								spec.get_children()[i].talent = talent_info.talent_trees[unit][talent_tree][i]
								spec.get_children()[i].tooltip_text = spec.get_children()[i].talent
								spec.get_children()[i].selected_unit = unit
								spec.get_children()[i].unit_info = unit_info
								if spec.get_children()[i].talent in unit_info.character_attributes[unit]['talents']:
									spec.get_children()[i].self_modulate = Color(.25, .25, .25)
								else:
									spec.get_children()[i].self_modulate = Color(1, 1, 1)
