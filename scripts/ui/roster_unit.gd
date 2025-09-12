extends VBoxContainer
@onready var texture_button = $TextureButton
@onready var label = $Label
@onready var unit_info = %UnitInfo
@export var unit_name: String = ''
var attributes: Dictionary
var on_squad: bool = false
@onready var unit_holder = %"Unit Holder"
@onready var game_manager = %"Game Manager"
@onready var add_to_squad = $AddToSquad


func _ready():
	update()


func update():
	if unit_name != '':
		texture_button.self_modulate = Color(1, 1, 1)
		attributes = unit_info.character_attributes[unit_name]
		texture_button.texture_normal = load(attributes['texture'])
	for unit in unit_holder.get_children():
		if unit.unit_name == unit_name:
			on_squad = true


func _on_texture_button_pressed():
	if on_squad:
		add_to_squad.hide()
	else:
		add_to_squad.show()
	if label.text == '':
		label.text = ''
		for key in attributes:
			if key != 'unit_actions' and key != 'texture':
				label.text += key.replace('_', ' ').to_upper() + ': ' + str(attributes[key]) + '\n'
	else:
		add_to_squad.hide()
		label.text = ''


func _on_add_to_squad_pressed():
	game_manager.roster_unit_selected = self
	game_manager.changing_squad = true
