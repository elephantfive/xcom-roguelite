extends Control

var selected_unit
@onready var tree_container = %TreeContainer
@onready var talent_info = %TalentInfo
@onready var unit_info = %UnitInfo
@onready var game_manager = %"Game Manager"
@onready var talent_character_changes = %TalentCharacterChanges
const TALENT_TREE_BUTTON = preload("res://scenes/ui/talent_tree_button.tscn")

var current_unit


func _on_level_up_state_entered():
	talent_character_changes.unit_info = unit_info
	for unit in unit_info.character_attributes:
		if unit_info.character_attributes[unit].has('xp'):
			if unit_info.character_attributes[unit]['xp'] >= unit_info.character_attributes[unit]['xp_needed']:
				selected_unit = unit
				break

	while unit_info.character_attributes[selected_unit]['xp'] >= unit_info.character_attributes[selected_unit]['xp_needed']:
		unit_info.character_attributes[selected_unit]['xp'] -= unit_info.character_attributes[selected_unit]['xp_needed']
		unit_info.character_attributes[selected_unit]['talent_points'] += 1
		unit_info.character_attributes[selected_unit]['level'] += 1
		unit_info.character_attributes[selected_unit]['xp_needed'] *= 2

	for spec in tree_container.get_children():
		for talent_tree in talent_info.talent_trees[selected_unit]:
			if spec.name == talent_tree:
				for tier in talent_info.talent_trees[selected_unit][talent_tree]:
					for talent in tier:
						var new_talent_button = TALENT_TREE_BUTTON.instantiate()
						new_talent_button.tier = talent_info.talent_trees[selected_unit][talent_tree].find(tier)
						new_talent_button.talent = talent
						new_talent_button.tooltip_text = talent
						new_talent_button.selected_unit = selected_unit
						new_talent_button.unit_info = unit_info
						new_talent_button.talent_character_changes = talent_character_changes
						spec.get_children()[new_talent_button.tier].add_child(new_talent_button)
						if new_talent_button.tier == 0 and new_talent_button.talent not in unit_info.character_attributes[selected_unit]['talents']:
							new_talent_button.state_chart.send_event.call_deferred('clickable')
						elif talent in unit_info.character_attributes[selected_unit]['talents']:
							new_talent_button.state_chart.send_event.call_deferred('in_talents')
	for child in tree_container.get_children():
		print(str(child.position))


func _on_exit_pressed():
	for spec in tree_container.get_children():
		for tier in spec.get_children():
			for talent in tier.get_children():
				talent.queue_free()
	game_manager.state_chart.send_event('idle')
