extends TextureButton
var talent: Talent
var tier: int
var selected_unit
var unit_info: Node
var talent_character_changes
@onready var state_chart = $StateChart

func _on_pressed():
	state_chart.send_event('clicked')


func _on_clickable_event_received(event):
	if event == 'clicked':
		if selected_unit.attributes.talent_points > 0:
			selected_unit.attributes.talent_points -= 1
			if selected_unit.attributes.talents.has(talent):
				selected_unit.attributes.talents[talent] += 1
			else:
				selected_unit.attributes.talents[talent] = 1
			if selected_unit.attributes.talents[talent] == talent.max_points:
				state_chart.send_event('maxed')
			talent_character_changes.selected_unit = selected_unit
			talent_character_changes.add_talent(talent)
			state_chart.send_event('in_talents')


func _on_not_clickable_state_entered():
	self_modulate = Color(.25, .25, .25)


func _on_clickable_state_entered():
	self_modulate = Color(1, 1, 1)


func _on_in_state_entered():
	for child in get_parent().get_parent().get_children()[tier + 1].get_children():
		child.state_chart.send_event.call_deferred('clickable')


func _on_maxed_state_entered():
	state_chart.send_event.call_deferred('not_clickable')
