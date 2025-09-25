extends Node2D
@onready var entities = $Entities
@onready var player_spawns = $PlayerSpawns
@onready var camera = $Camera2D

@export var level_name: String

@export var random_rewards: Array = []
@export var rewards: Dictionary[String, int]

@export var random_on: bool = true
@export var rewards_on: bool = true

#Thanks to Godot forum users Dodolta & Ulukanovich. No idea why this was so hard for me
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP and camera.zoom.x > 0.25 and camera.zoom.y > 0.25:
				camera.zoom.x -= 0.25
				camera.zoom.y -= 0.25
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				camera.zoom.x += 0.25
				camera.zoom.y += 0.25
