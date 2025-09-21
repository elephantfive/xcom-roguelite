extends Control
@onready var game_manager = %"Game Manager"
const INVENTORY_BUTTON = preload("uid://bkkexc6sgwsb")
@onready var state_chart = $StateChart
@onready var inventory = $CharacterAndInventory/Inventory/Inventory
var selected_item: InventoryButton
var selected_slot: PaperDollButton
@onready var character_label = $CharacterAndInventory/Character/CharacterLabel
@onready var item_label = $CharacterAndInventory/Inventory/ItemLabel
@onready var equip = $CharacterAndInventory/Character/Buttons/Equip
@onready var unequip = $CharacterAndInventory/Character/Buttons/Unequip
@onready var character_left = $CharacterAndInventory/Character/Character/CharacterLeft
@onready var character_right = $CharacterAndInventory/Character/Character/CharacterRight


func _on_loadout_state_entered():
	for item in inventory.get_children():
		item.queue_free()
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
	equip.show()


func _on_slot_state_entered():
	character_label.text = ''
	if selected_slot.obj != null:
		unequip.show()
		character_label.text += selected_slot.obj.item_name


func _on_item_event_received(event):
	if event == 'slot':
		slot_check()


func _on_slot_event_received(event):
	if event == 'item':
		slot_check()

func slot_check():
	if selected_item != null:
		if selected_item.obj.slot == selected_slot.slot:
			if selected_slot.obj != null:
				_unequip()
			selected_slot.obj = selected_item.obj
			selected_slot.texture_normal = selected_item.obj.texture
			game_manager.inventory.erase(selected_item.obj)
			selected_item.queue_free()
			state_chart.send_event('noitem')
			state_chart.send_event('noslot')


func _on_no_item_state_entered():
	equip.hide()
	selected_item = null
	item_label.text = ''


func _on_no_slot_state_entered():
	slot_clear()


func _on_equip_pressed():
	for slot_button in character_left.get_children():
		selected_slot = slot_button
		slot_check()
	for slot_button in character_right.get_children():
		selected_slot = slot_button
		slot_check()


func _on_unequip_pressed():
	_unequip()
	state_chart.send_event('noslot')
	

func _unequip():
	create_button(selected_slot.obj)
	game_manager.inventory.append(selected_slot.obj)
	selected_slot.obj = null


func slot_clear():
	unequip.hide()
	selected_slot = null
	character_label.text = ''
