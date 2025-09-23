extends CharacterBody2D
class_name Enemy

var current_closest_enemy: CharacterBody2D
var game_manager: Node
var hud: CanvasLayer
var targets:Array = []
var type: String = 'enemy'

var moving: bool = true
var distance_moved: float = 0
var last_position: Vector2
@export var max_move_distance: float = 200.0
@export var movement_speed: float = 200.0
@export var hp: int = 2
@export var speed: int = 100
@export var attack_distance: int = 100
@export var xp: int = 50
@export var damage: int = 1
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

const projectile = preload("res://scenes/entities/projectiles/projectile.tscn")

func _ready():
	navigation_agent.path_desired_distance = 2.0
	navigation_agent.target_desired_distance = 2.0

func _on_game_manager_turn_start():
	distance_moved = 0
	last_position = global_position
	moving = true
	if game_manager.turn == str(self):
		if current_closest_enemy == null:
			current_closest_enemy = targets[randi_range(0, targets.size()-1)]
		for target in targets:
			if position.distance_to(target.position) <= attack_distance:
				moving = false
				attack()
				break
			elif position.distance_to(target.position) < position.distance_to(current_closest_enemy.position):
				moving = true
				current_closest_enemy = target
				set_movement_target(current_closest_enemy.position)


func _physics_process(_delta):
	if game_manager.turn == str(self):
		if moving:
			if position.distance_to(current_closest_enemy.position) > attack_distance and distance_moved < max_move_distance:
				move()
			elif position.distance_to(current_closest_enemy.position) <= attack_distance and distance_moved < max_move_distance:
				attack()
				moving = false
			else:
				game_manager.state_chart.send_event('turn_end')
				moving = false


func move():
	if navigation_agent.is_navigation_finished():
		if position.distance_to(current_closest_enemy.position) > attack_distance:
			set_movement_target(current_closest_enemy.position)
		else:
			print("Done moving?")
			attack()
		
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	
	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()
	distance_moved += global_position.distance_to(last_position)
	last_position = global_position
			
			
func attack():
	pass

func take_damage(incoming_damage):
	hp -= incoming_damage
	
	if hp <= 0:
		game_manager.turns.erase(str(self))
		if game_manager.turn == str(self):
			game_manager.turn_adv()
		for entity in get_parent().get_children():
			if entity.type == 'ally':
				entity.attributes['xp'] += xp
		queue_free()

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target
