extends HBoxContainer
const ROSTER_UNIT = preload("uid://c4ncj5ewtvx0p")

func _ready():
	add_unit(load("res://resources/ally_stats/characters/amigol.tres"))

func add_unit(attributes: CharacterAttributes):
	var new_unit = ROSTER_UNIT.instantiate()
	add_child(new_unit)
	new_unit.attributes = attributes
	new_unit.game_manager = %"Game Manager"
	new_unit.unit_roster = self
	new_unit.unit_holder = %"Unit Holder"
