extends Control

var selected_item: InventoryButton
var selected_slot: PaperDollButton
var selected_unit: CharacterAttributes

@onready var game_manager = %"Game Manager"
@onready var state_chart = $StateChart
@onready var inventory = $CharacterAndInventory/Inventory/Inventory
@onready var character_label = $CharacterAndInventory/Character/CharacterLabel
@onready var item_label = $CharacterAndInventory/Inventory/ItemLabel
@onready var equip = $CharacterAndInventory/Character/Buttons/Equip
@onready var unequip = $CharacterAndInventory/Character/Buttons/Unequip
@onready var character_portrait = $CharacterAndInventory/Character/Character/CharacterPortrait
@onready var unit_holder = %"Unit Holder"
@onready var unit_roster = %"Unit Roster"
@onready var character = $CharacterAndInventory/Character/Character

const ICON = preload("uid://dtpa1tam2fmgh")
const INVENTORY_BUTTON = preload("uid://bkkexc6sgwsb")


func _ready():
	for unit in unit_holder.get_children():
		if unit.attributes != null:
			selected_unit = unit.attributes
			character_portrait.texture = unit.attributes.texture
			break

func _on_loadout_state_entered():
	for item in inventory.get_children():
		item.queue_free()
	for item in game_manager.inventory:
		create_button(item)


func create_button(obj: Item):
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


func _on_item_event_received(event):
	if event == 'slot':
		slot_check()


func _on_slot_event_received(event):
	if event == 'item':
		slot_check()

func slot_check(unit: CharacterAttributes = null):
	if unit == null:
		if selected_item != null:
			if selected_item.obj.slot == selected_slot.slot:
				if selected_slot.obj != null:
					_unequip()
				selected_slot.obj = selected_item.obj
				selected_slot.texture_normal = selected_item.obj.texture
				for value in selected_slot.obj.modified_values:
					selected_unit.set(value, selected_unit.get(value) + selected_slot.obj.modified_values[value])
				selected_unit.items.append(selected_slot.obj)
				game_manager.inventory.erase(selected_item.obj)
				selected_item.queue_free()
				state_chart.send_event('noitem')
				state_chart.send_event('noslot')
	else:
		for child in character.get_children():
			if child.is_class('VBoxContainer'):
				for slot_button in child.get_children():
					slot_button.obj = null
					slot_button.texture_normal = ICON
				for item in unit.items:
					for slot_button in child.get_children():
						if item.slot == slot_button.slot:
							slot_button.obj = item
							slot_button.texture_normal = item.texture


func _on_no_item_state_entered():
	equip.hide()
	selected_item = null
	item_label.text = ''


func _on_no_slot_state_entered():
	slot_clear()
	char_text_update()


func _on_equip_pressed():
	for child in character.get_children():
		if child.is_class('VBoxContainer'):
			for slot_button in child.get_children():
				selected_slot = slot_button
				slot_check()


func _on_unequip_pressed():
	_unequip()
	state_chart.send_event('noslot')
	

func _unequip():
	for value in selected_slot.obj.modified_values:
		selected_unit.set(value, selected_unit.get(value) - selected_slot.obj.modified_values[value])
	create_button(selected_slot.obj)
	game_manager.inventory.append(selected_slot.obj)
	selected_unit.items.erase(selected_slot.obj)
	selected_slot.obj = null
	selected_slot.texture_normal = ICON


func slot_clear():
	unequip.hide()
	selected_slot = null
	character_label.text = ''


func _on_next_pressed():
	state_chart.send_event('noslot')
	state_chart.send_event('noitem')
	for i in range(unit_roster.get_child_count()):
		if unit_roster.get_children()[i] != null:
			if unit_roster.get_children()[i].attributes != selected_unit:
				selected_unit = unit_roster.get_children()[i].attributes
				slot_check(selected_unit)
				character_portrait.texture = selected_unit.texture
				break
	char_text_update()



func _on_prev_pressed():
	state_chart.send_event('noslot')
	state_chart.send_event('noitem')
	for i in range(unit_roster.get_child_count() - 1, -1, -1):
		if unit_roster.get_children()[i] != null:
			if unit_roster.get_children()[i].attributes != selected_unit:
				selected_unit = unit_roster.get_children()[i].attributes
				slot_check(selected_unit)
				character_portrait.texture = selected_unit.texture
				break
	char_text_update()

func char_text_update():
	character_label.text = ''
	for property_info in selected_unit.get_script().get_script_property_list():
		if typeof(selected_unit.get(property_info.name)) == 2 or typeof(selected_unit.get(property_info.name)) == 4:
			character_label.text += property_info.name.replace('_', ' ').to_upper() + ': ' + str(selected_unit.get(property_info.name)) + '|'
