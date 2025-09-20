extends Control

@onready var game_manager = %"Game Manager"
var shop_characters: Array[CharacterAttributes]
var shop_items: Array[Item]
var shop_artifacts: Array[Artifact]
@onready var row_container = $RowContainer
const SHOP_BUTTON = preload("uid://ban4sjpxrncql")


func _on_shop_state_entered():
	var shops = [shop_characters, shop_items, shop_artifacts]
	for i in range(shops.size()):
		load_items(shops[i], row_container.get_children()[i])


func load_items(shop, row):
	for i in range(shop.size()):
		var new_button = SHOP_BUTTON.instantiate()
		new_button.obj = shop[i]
		new_button.game_manager = game_manager
		row.add_child(new_button)
		new_button.texture_button.texture_normal = shop[i].texture
		if new_button.obj.get('item_name') != null:
			new_button.label.text = new_button.obj.item_name
		else:
			new_button.label.text = new_button.obj.character_name


func _on_exit_pressed():
	game_manager.state_chart.send_event('idle')
