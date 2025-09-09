extends Area2D
@onready var game_manager: Node
@onready var hud: CanvasLayer
var targets:Array = []
var damage: int = 1
var type: String = 'enemy'
const projectile = preload("res://projectiles/projectile.tscn")

func _ready():
	targets = game_manager.targets

func _on_game_manager_turn_start():
	if game_manager.turn == name:
		var target = targets[randi_range(0, targets.size()-1)]
		var new_proj = projectile.instantiate()
		new_proj.target = target.global_position
		new_proj.alignment = 'enemy'
		new_proj.damage = damage
		new_proj.game_manager = game_manager
		add_child(new_proj)
		game_manager.turn_end()


func take_damage():
	game_manager.turns.erase(name)
	if game_manager.turn == name:
		game_manager.turn_adv()
	queue_free()
