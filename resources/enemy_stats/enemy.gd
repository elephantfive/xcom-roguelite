extends Area2D
class_name Enemy

var current_closest_enemy: Area2D
var game_manager: Node
var hud: CanvasLayer
var targets:Array = []
var type: String = 'enemy'

@export var hp: int = 2
@export var speed: int = 100
@export var attack_distance: int = 100
@export var xp: int = 50
@export var damage: int = 1


const projectile = preload("res://scenes/entities/projectiles/projectile.tscn")

func _on_game_manager_turn_start():
	if game_manager.turn == str(self):
		if current_closest_enemy == null:
			current_closest_enemy = targets[randi_range(0, targets.size()-1)]
		for target in targets:
			if position.distance_to(target.position) <= attack_distance:
				attack()
				break
			elif position.distance_to(target.position) < position.distance_to(current_closest_enemy.position):
				current_closest_enemy = target
		if position.distance_to(current_closest_enemy.position) > attack_distance:
			position = position.move_toward(current_closest_enemy.position, speed)
			game_manager.state_chart.send_event('turn_end')

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
