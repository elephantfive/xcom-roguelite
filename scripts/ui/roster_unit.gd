extends VBoxContainer

@onready var texture_button = $TextureButton
@onready var label = $Label
@export var unit_name: String = ''

var attributes: Dictionary

var on_squad: bool = false

@onready var add_to_squad = $AddToSquad
var unit_info
var unit_holder
var game_manager
var unit_roster


func update():
	if unit_name != '':
		texture_button.self_modulate = Color(1, 1, 1)
		attributes = unit_info.character_attributes[unit_name]
		texture_button.texture_normal = load(attributes['texture'])
	for unit in unit_holder.get_children():
		if unit.unit_name == unit_name:
			on_squad = true


func _on_texture_button_pressed():
	for unit in unit_roster.get_children():
		if unit.unit_name != unit_name:
			unit.label.text = ''
			unit.add_to_squad.hide()
			
	if on_squad:
		add_to_squad.hide()
	else:
		add_to_squad.show()
		
	if label.text == '':
		for key in attributes:
			if key != 'unit_actions' and key != 'texture':
				label.text += key.replace('_', ' ').to_upper() + ': ' + str(attributes[key]) + '\n'
	else:
		add_to_squad.hide()
		label.text = ''

func _input(event):
	if game_manager.changing_squad:
		if event.is_action_pressed("right_click"):
			game_manager.squad_unit_selected = null
			game_manager.roster_unit_selected = null
			game_manager.changing_squad = false


func _on_add_to_squad_pressed():
	for unit in unit_holder.get_children():
		unit.label.text = ''
		unit.remove_from_squad.hide()
		
	for unit in unit_roster.get_children():
		unit.label.text = ''
		unit.add_to_squad.hide()
		
	game_manager.squad_unit_selected = null
	game_manager.roster_unit_selected = self
	game_manager.changing_squad = true
	
