extends TextureButton
class_name InventoryButton

var obj: Item
var loadout_screen: Control


func _ready():
	loadout_screen = get_node('/root/Game/Loadout/LoadoutScreen')


func _on_pressed():
	loadout_screen.item_label.text = ''
	if loadout_screen.selected_item != self:
		loadout_screen.selected_item = self
		loadout_screen.item_label.text += obj.item_name
		loadout_screen.state_chart.send_event('item')
	else:
		loadout_screen.state_chart.send_event('noitem')
