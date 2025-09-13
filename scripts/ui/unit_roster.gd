extends HBoxContainer
const ROSTER_UNIT = preload("res://scenes/ui/roster_unit.tscn")

func _ready():
	add_unit('Nidys')

func add_unit(unit_name):
	var new_unit = ROSTER_UNIT.instantiate()
	add_child(new_unit)
	new_unit.unit_name = unit_name
	new_unit.game_manager = %"Game Manager"
	new_unit.unit_roster = self
	new_unit.unit_holder = %"Unit Holder"
	new_unit.unit_info = %UnitInfo
	new_unit.update()
