extends TextureButton
@onready var hud = %HUD


var attributes = {
	'name': 'Amigol',
	'attack_damage': 1,
	'health':  10,
	'max_move_distance':  20,
	'max_attack_distance': 20,
	'unit_actions': ["Attack"],
	'texture': "res://icon.svg",
}


func _ready():
	texture_normal = load(attributes['texture'])


func _on_pressed():
	hud.label.text = ''
	for key in attributes:
		if key != 'unit_actions' and key != 'texture':
			hud.label.text += key.replace('_', ' ').to_upper() + ': ' + str(attributes[key]) + '\n'
