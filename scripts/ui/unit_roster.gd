extends HBoxContainer
const ROSTER_UNIT = preload("res://scenes/ui/roster_unit.tscn")

func _ready():
	var new_unit = ROSTER_UNIT.instantiate()
	add_child(new_unit)
	new_unit.game_manager = %"Game Manager"
	new_unit.unit_roster = self
	new_unit.unit_holder = %"Unit Holder"
	new_unit.unit_info = %UnitInfo
	new_unit.unit_name = 'Amigol'
	new_unit.update()
