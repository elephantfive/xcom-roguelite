extends Resource
class_name CharacterAttributes

@export var character_name: String
@export var attack_damage: int =  2
@export var attack_ap_cost: int =  1
@export var base_health: int =   20
@export var health: int = 20
@export var heal: int =  3
@export var max_overheal: int =  5
@export var heal_ap_cost: int =  1
@export var max_heal_distance: int =  10
@export var max_move_distance: int =   20
@export var max_attack_distance: int =  20
@export var max_action_points: int =  1
@export var specializations: Array[Specialization]
@export var xp: int =  0
@export var xp_needed: int =  100
@export var level: int =  1
@export var talents: Dictionary =  {}
@export var talent_points: int =  0
@export var price: int = 10
@export var unit_actions: Array =  ['Attack', 'Move']
@export var texture:Texture2D = load("res://icon.svg")
