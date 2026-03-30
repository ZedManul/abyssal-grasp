class_name ShipTransition extends Node

@export var destination_reference: Node2D
@export var destination_exit: Node2D

@export var velocity_reference: Node2D

func activate(i: PlayerController) -> void:
	i.get_parent().remove_child(i)
	if destination_reference:
		destination_reference.add_child(i)
		if velocity_reference is RigidBody2D:
			i.velocity -= velocity_reference.linear_velocity
	else:
		GlobalRefs.main_scene.add_child(i)
		if velocity_reference is RigidBody2D:
			i.velocity += velocity_reference.linear_velocity
	if destination_exit:
		i.global_position = destination_exit.global_position
		i.global_rotation = destination_exit.global_rotation
