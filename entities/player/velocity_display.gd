class_name VelocityDisplay extends Line2D

@export var body: Node2D
@export var gizmo_scale: float = 1.0

func _physics_process(delta: float) -> void:
	global_rotation = 0.0
	clear_points()
	add_point(Vector2.ZERO)
	if not body: return
	if body is CharacterBody2D:
		add_point(body.velocity * gizmo_scale)
	
	if body is RigidBody2D:
		add_point(body.linear_velocity * gizmo_scale)
