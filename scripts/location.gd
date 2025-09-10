extends Area2D

var type: String = 'location'
@export var level: String
@export var desc_text: String
@onready var popup = $Popup
@onready var desc = $Popup/Desc
@onready var game_manager = %"Game Manager"

func _ready():
	desc.text = desc_text


func _on_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed('left_click'):
		desc.hide()
		popup.show()


func _on_exit_pressed():
	popup.hide()


func _on_info_pressed():
	if desc.visible == false:
		desc.show()
	else:
		desc.hide()


func _on_begin_level_pressed():
	popup.hide()
	game_manager.level_adv(level)
