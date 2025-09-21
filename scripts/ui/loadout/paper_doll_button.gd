extends TextureButton
class_name PaperDollButton

var obj: Item
@export var slot: String
@export var default_texture: Texture2D
@export var empty: bool = true
var loadout_screen: Control


func _ready():
	loadout_screen = get_node('/root/Game/Loadout/LoadoutScreen')


func _on_pressed():
	if loadout_screen.selected_slot != self:
		loadout_screen.selected_slot = self
		loadout_screen.state_chart.send_event('slot')
	else:
		loadout_screen.state_chart.send_event('noslot')
	
