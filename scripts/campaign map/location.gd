extends Area2D

var type: String = 'location'
@export var location_type: String = 'level'
@export var level: String
@export var desc_text: String
@onready var popup = $Popup
@onready var desc = %Desc
@onready var game_manager = %"Game Manager"
@onready var player_marker = %"Player Marker"
@export var min_distance: int = 100
@onready var campaign_map_hud = %"Campaign Map Hud"
@onready var shop_screen = %ShopScreen

@export var shop_characters: Array[CharacterAttributes]
@export var shop_items: Array[Item]
@export var shop_artifacts: Array[Artifact]

func _ready():
	desc.text = desc_text
	if location_type == 'shop':
		$ColorRect.color = Color(0, 1, 1)


func _on_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed('left_click'):
		if player_marker.moving == false:
			if player_marker.position.distance_to(self.position) <= min_distance:
				campaign_map_hud.hide()
				if location_type == 'level':
					desc.hide()
					popup.show()
				elif location_type == 'shop':
					shop_screen.shop_characters = shop_characters
					shop_screen.shop_items = shop_items
					shop_screen.shop_artifacts = shop_artifacts
					game_manager.state_chart.send_event('shop')
			else:
				#TO-DO: Implement highlighting/something to indicate that players are too far
				pass
				


func _on_exit_pressed():
	campaign_map_hud.show()
	popup.hide()


func _on_begin_level_pressed():
	popup.hide()
	game_manager.level_path = level
	game_manager.state_chart.send_event('level_start')
	
