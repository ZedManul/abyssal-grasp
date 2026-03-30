extends StaticBody2D

@export var ship: RigidBody2D

func _physics_process(delta: float) -> void:
	constant_linear_velocity = ship.linear_velocity
