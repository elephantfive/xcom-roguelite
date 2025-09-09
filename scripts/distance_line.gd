extends Line2D
@onready var collision_shape = $"Distance Line Collision/CollisionShape2D"


func _process(_delta):
	collision_shape.shape.a = points[0]
	collision_shape.shape.b = points[1]
