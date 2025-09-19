extends Resource
class_name Item

@export var item_type: String
@export var item_name: String
@export var texture: Texture2D
@export var price: int
@export var add_ability: bool = false
@export var modified_values: Dictionary[String, int]
