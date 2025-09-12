extends TextureButton
@onready var unit_info = %UnitInfo
@onready var label = $"../../UnitDesc/Label"
@export var unit_name: String
var attributes: Dictionary
@onready var unit_roster = %"Unit Roster"
var selected: bool = false
@onready var game_manager = %"Game Manager"
@onready var unit_holder = %"Unit Holder"


func _ready():
	update()


func _on_pressed():
	var valid = true
	if game_manager.changing_squad:
		for unit in unit_holder.get_children():
			if unit.unit_name == game_manager.roster_unit_selected.unit_name:
				game_manager.roster_unit_selected = null
				game_manager.changing_squad = false
				valid = false
				break
		if valid:
			unit_name = game_manager.roster_unit_selected.unit_name
			game_manager.roster_unit_selected.add_to_squad.hide()
			game_manager.roster_unit_selected.update()
			game_manager.roster_unit_selected = null
			game_manager.changing_squad = false
			update()
			
	else:
		label.text = ''
		if not selected:
			selected = true
			for key in attributes:
				if key != 'unit_actions' and key != 'texture':
					label.text += key.replace('_', ' ').to_upper() + ': ' + str(attributes[key]) + '\n'
		else:
			selected = false
			label.text = ''
			
func update():
	if unit_name != '':
		self_modulate = Color(1, 1, 1)
		attributes = unit_info.character_attributes[unit_name]
		texture_normal = load(attributes['texture'])
	else:
		self_modulate = Color(.25, .25, .25)
