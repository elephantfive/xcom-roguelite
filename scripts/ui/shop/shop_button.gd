extends VBoxContainer
@onready var label = $Label
@onready var texture_button = $TextureButton
var game_manager: Node
var obj


func _on_texture_button_pressed():
	if obj != null:
		if game_manager.money >= obj.price:
			game_manager.money -= obj.price
			if obj.get('item_name') != null:
				game_manager.inventory.append(obj)
			else:
				game_manager.unit_roster.add_unit(obj)
			queue_free()
