class_name PlayerController extends CharacterBody2D

const FLIGHT_ACCEL := 1000.0
const INERTIA_RESET_TIMER := 0.1
const FRICTION := 0.9

var motion_input: Vector2
var direction_input: Vector2
var sub_world: ShipSubWorld
var input_lock: bool = false


func _ready() -> void:
	GlobalRefs.player_node = self


func _enter_tree() -> void:
	var sw: = get_viewport().get_parent()
	if sw is ShipSubWorld:
		sub_world = sw
	else:
		sub_world = null



func _physics_process(delta: float) -> void:
	motion_input = Vector2(
			Input.get_axis("move_left","move_right"),
			Input.get_axis("move_up","move_down")
			).normalized()
	
	if !input_lock:
		direction_input = get_global_mouse_position() - global_position
		global_rotation = direction_input.angle()
	else:
		direction_input = Vector2.ZERO
		motion_input = Vector2.ZERO
	
	var offset_rotation: float = 0.0
	if sub_world:
		offset_rotation = sub_world.world_transform_anchor.global_rotation
	
	velocity += motion_input.rotated(-offset_rotation) * FLIGHT_ACCEL * delta
	move_and_slide()
	velocity = get_real_velocity() * FRICTION
