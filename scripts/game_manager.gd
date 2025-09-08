extends Node
var turn: String
signal turn_start
signal turn_end
var selected_unit: Area2D

func _ready():
	turn_start.emit()
	turn = "player"


func _on_turn_start():
	pass # Replace with function body.


func _on_turn_end():
	pass # Replace with function body.
