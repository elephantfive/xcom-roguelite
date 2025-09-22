extends HBoxContainer
const ROSTER_UNIT = preload("uid://c4ncj5ewtvx0p")
@onready var squad_unit = $"../../Unit Holder/SquadUnit"

func _ready():
	add_unit(load("res://resources/ally_stats/characters/amigol.tres"))
	for unit in get_children():
		squad_unit.attributes = unit.attributes
		squad_unit.update()

func add_unit(attributes: CharacterAttributes):
	var new_unit = ROSTER_UNIT.instantiate()
	add_child(new_unit)
	new_unit.attributes = attributes
	new_unit.game_manager = %"Game Manager"
	new_unit.unit_roster = self
	new_unit.unit_holder = %"Unit Holder"
