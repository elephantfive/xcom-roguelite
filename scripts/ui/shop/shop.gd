extends Control

var shop_characters: Array[CharacterAttributes]
var shop_items: Array[Item]
var shop_artifacts: Array[Artifact]
@onready var row_container = $RowContainer



func _on_shop_state_entered():
	var shops = [shop_characters, shop_items, shop_artifacts]
	print("Shop state entered!")
	for i in range(shops.size()):
		load_items(shops[i], row_container.get_children()[i])

func load_items(shop, row):
	for i in range(shop.size()):
		row.get_children()[i].obj = shop[i]
		row.get_children()[i].texture_button.texture_normal = row.get_children()[i].obj.texture
