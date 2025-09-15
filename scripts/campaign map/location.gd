extends Area2D

var type: String = 'location'
@export var level: String
@export var desc_text: String
@onready var popup = $Popup
@onready var desc = %Desc
@onready var game_manager = %"Game Manager"
@onready var player_marker = %"Player Marker"
@export var min_distance: int = 100
@onready var campaign_map_hud = %"Campaign Map Hud"

func _ready():
	desc.text = desc_text


func _on_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed('left_click'):
		campaign_map_hud.hide()
		if player_marker.moving == false:
			if  player_marker.position.distance_to(self.position) <= min_distance:
				desc.hide()
				popup.show()
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
	
