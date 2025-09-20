extends Control
@onready var game_manager = %"Game Manager"
const INVENTORY_BUTTON = preload("uid://bkkexc6sgwsb")
@onready var inventory = $HBoxContainer/Inventory/Inventory


func _on_loadout_state_entered():
	for item in game_manager:
		var new_item = INVENTORY_BUTTON.instantiate()
		new_item.obj = item
		inventory.add_child(new_item)
		
