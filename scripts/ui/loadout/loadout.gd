extends Control
@onready var game_manager = %"Game Manager"
const INVENTORY_BUTTON = preload("uid://bkkexc6sgwsb")
@onready var state_chart = $StateChart
@onready var inventory = $CharacterAndInventory/Inventory/Inventory
var selected_button
var selected_slot
@onready var character_label = $CharacterAndInventory/Character/CharacterLabel
@onready var item_label = $CharacterAndInventory/Inventory/ItemLabel


func _on_loadout_state_entered():
	for item in game_manager.inventory:
		create_button(item)


func create_button(obj):
	var new_item = INVENTORY_BUTTON.instantiate()
	new_item.obj = obj
	new_item.tooltip_text = obj.item_name
	new_item.texture_normal = obj.texture
	inventory.add_child(new_item)


func _on_exit_pressed():
	game_manager.state_chart.send_event('idle')
