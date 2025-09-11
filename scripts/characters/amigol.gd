extends TextureButton

var attributes = {
	'attack_damage': 1,
	'health':  10,
	'max_move_distance':  20,
	'max_attack_distance': 20,
	'unit_actions': ["Attack"],
	'texture': "res://icon.svg",
}


func _ready():
	texture_normal = load(attributes['texture'])
