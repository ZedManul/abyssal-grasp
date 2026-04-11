class_name PlayerShip extends RigidBody2D



@export var helm_pilot_position: Node2D

var motion_input: Vector2
var helm_active: bool = false

@onready var helm_ui: CanvasLayer = %HelmUI

func _physics_process(delta: float) -> void:
	process_helm_input(delta)
	

func _on_helm_interacted(player_node: PlayerController) -> void:
	helm_active = !helm_active
	player_node.input_lock = helm_active
	player_node.velocity = Vector2.ZERO
	player_node.global_position = helm_pilot_position.global_position
	player_node.global_rotation = helm_pilot_position.global_rotation
	
	var zoom_anim: Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC).set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	var zoom_target: Vector2 = Vector2.ONE
	if helm_active:
		zoom_target = Vector2(0.25,0.25)
	zoom_anim.tween_property(GlobalRefs.main_camera,"zoom",zoom_target,2.0)
	#helm_ui.visible = helm_active

func process_helm_input(delta: float) -> void:
	if !helm_active: return
	motion_input = Vector2(
		Input.get_axis("move_down","move_up"),
		Input.get_axis("move_left","move_right")
		).normalized()
	apply_central_impulse(Vector2.from_angle(global_rotation)*motion_input.x * 1000.0 )
	apply_torque_impulse(motion_input.y * (motion_input.x) * 40000.0)
	
