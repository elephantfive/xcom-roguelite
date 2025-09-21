extends TextureButton
var obj: Item
var loadout_screen: Control

func _ready():
	loadout_screen = get_node('/root/Game/Loadout/LoadoutScreen')


func _on_pressed():
	loadout_screen.item_label.text = ''
	if loadout_screen.selected_button != self:
		loadout_screen.selected_button = self
		loadout_screen.item_label.text += obj.item_name
	else:
		loadout_screen.selected_button = null
