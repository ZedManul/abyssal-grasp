class_name InertialFrameArea extends Area2D

@export var reference_body: RigidBody2D

func _physics_process(delta: float) -> void:
	for i: PhysicsBody2D in get_overlapping_bodies():
		if !(i is PlayerController): continue
		var player = i as PlayerController
		if player.inertia_ref == reference_body: continue
		
