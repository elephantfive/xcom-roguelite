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
@onready var character_left = $CharacterAndInventory/Character/Character/CharacterLeft
@onready var character_right = $CharacterAndInventory/Character/Character/CharacterRight
@onready var unit_holder = %"Unit Holder"
@onready var unit_roster = %"Unit Roster"

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
		character_label.text += selected_slot.obj.item_name


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
					selected_unit.value += selected_slot.obj.modified_values[value]
				selected_unit.items.append(selected_slot.obj)
				game_manager.inventory.erase(selected_item.obj)
				selected_item.queue_free()
				state_chart.send_event('noitem')
				state_chart.send_event('noslot')
	else:
		for slot_button in character_left.get_children():
			slot_button.obj = null
			slot_button.texture_normal = ICON
		for slot_button in character_right.get_children():
			slot_button.obj = null
			slot_button.texture_normal = ICON
		for item in unit.items:
			for slot_button in character_left.get_children():
				if item.slot == slot_button.slot:
					slot_button.obj = item
					slot_button.texture_normal = item.texture
			for slot_button in character_right.get_children():
				if item.slot == slot_button.slot:
					slot_button.obj = item
					slot_button.texture_normal = item.texture


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
	for value in selected_slot.obj.modified_values:
		selected_unit.value -= selected_slot.obj.modified_values[value]
	create_button(selected_slot.obj)
	game_manager.inventory.append(selected_slot.obj)
	selected_unit.items.erase(selected_slot.obj)
	selected_slot.obj = null


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
				print(str(selected_unit))
				selected_unit = unit_roster.get_children()[i].attributes
				slot_check(selected_unit)
				character_portrait.texture = selected_unit.texture
				break



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

func _process(_delta):
	if selected_unit != null:
		$Label.text = str(selected_unit.items)
