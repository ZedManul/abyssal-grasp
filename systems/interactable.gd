class_name Interactable extends Area2D

signal interaction(player: PlayerController)


func _physics_process(delta: float) -> void:
	if !Input.is_action_just_pressed("interact"): return
	for i in get_overlapping_bodies():
		if !(i is PlayerController): continue
		interaction.emit(i)
