extends Control
@onready var game_manager = %"Game Manager"
const INVENTORY_BUTTON = preload("uid://bkkexc6sgwsb")
@onready var state_chart = $StateChart
@onready var inventory = $CharacterAndInventory/Inventory/Inventory
var selected_button: InventoryButton
var selected_slot: PaperDollButton
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


func _on_item_state_entered():
	pass


func _on_slot_state_entered():
	character_label.text = ''
	if selected_slot.obj != null:
		character_label.text += selected_slot.obj.item_name


func _on_item_event_received(event):
	if event == 'slot':
		slot_check()


func _on_slot_event_received(event):
	if event == 'item':
		slot_check()

func slot_check():
	if selected_button.obj.slot == selected_slot.slot:
		selected_slot.obj = selected_button.obj
		selected_slot.texture_normal = selected_button.obj.texture
		state_chart.send_event('noitem')
		state_chart.send_event('noslot')
		selected_button.queue_free()


func _on_no_item_state_entered():
	selected_button = null
	item_label.text = ''


func _on_no_slot_state_entered():
	selected_slot = null
	character_label.text = ''
