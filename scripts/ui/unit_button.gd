extends TextureButton
@onready var unit_info = %UnitInfo
@onready var label = $"../../UnitDesc/Label"
@export var unit_name: String
var attributes: Dictionary
@onready var unit_roster = %"Unit Roster"
@onready var game_manager = %"Game Manager"
@onready var unit_holder = %"Unit Holder"
@onready var remove_from_squad = $"../../UnitDesc/RemoveFromSquad"


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
			for unit in unit_roster.get_children():
				if unit.unit_name == unit_name:
					unit.on_squad = false
			unit_name = game_manager.roster_unit_selected.unit_name
			game_manager.roster_unit_selected.add_to_squad.hide()
			game_manager.roster_unit_selected.update()
			game_manager.roster_unit_selected = null
			game_manager.squad_unit_selected = null
			game_manager.changing_squad = false
			update()
			
	else:
		if unit_name != '':
			remove_from_squad.show()
		label.text = ''
		if game_manager.squad_unit_selected != self:
			game_manager.squad_unit_selected = self
			for key in attributes:
				if key != 'unit_actions' and key != 'texture':
					label.text += key.replace('_', ' ').to_upper() + ': ' + str(attributes[key]) + '\n'
		else:
			remove_from_squad.hide()
			game_manager.squad_unit_selected = null
			
func update():
	if unit_name != '':
		self_modulate = Color(1, 1, 1)
		attributes = unit_info.character_attributes[unit_name]
		texture_normal = load(attributes['texture'])
	else:
		remove_from_squad.hide()
		attributes = {}
		self_modulate = Color(.25, .25, .25)


func _on_remove_from_squad_pressed():
	if game_manager.squad_unit_selected == self:
		for unit in unit_roster.get_children():
			if unit.unit_name == unit_name:
				unit.on_squad = false
		game_manager.squad_unit_selected = null
		unit_name = ''
		label.text = ''
		update()
