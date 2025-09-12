extends Node2D
@onready var entities = $Entities
@onready var player_spawns = $PlayerSpawns

@export var random_rewards: Array = []
@export var rewards: Array = []

@export var random_on: bool = true
@export var rewards_on: bool = true
