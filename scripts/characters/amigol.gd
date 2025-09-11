extends Node2D
var attack_damage: int = 1
var health: int = 10
var max_move_distance: int = 20
var current_move_points: float = max_move_distance
var max_attack_distance: int = 20

var unit_actions = ["Attack"]

var init_pos: Vector2
var too_far: bool = false
var moving: bool = false
var attacking: bool = false
var type: String = 'ally'
var thru_wall: bool = false
var current_distance: float
