extends Area2D
@onready var game_manager = %"Game Manager"
signal damage_dealt(target: Area2D, damage: int)
var targets:Array = []

func _ready():
	targets.append($"../Unit")

func _on_game_manager_turn_start():
	if game_manager.turn == "enemy":
		var target = targets[randi_range(0, targets.size()-1)]
		emit_signal("damage_dealt", target, 1)
		game_manager.turn_end()


func _on_area_entered(area):
	if area.type == 'proj':
		game_manager.turns.erase(name)
		if game_manager.turn == name:
			game_manager.turn_adv()
		area.queue_free()
		take_damage()

func take_damage():
	queue_free()
