extends Resource
class_name Talent

@export var talent_name: String
@export var talent_text: String
@export var max_points: int = 2
@export var current_points: int = 0
@export var tier: int = 0
@export var texture: Texture2D
@export var add_ability: bool = false
@export var modified_values: Dictionary[String, int]
