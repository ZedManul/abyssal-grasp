class_name PlayerCamera extends Camera2D

const mouse_weight: float = 0.5
const look_max_distance: float = 64.0


func _ready() -> void:
	GlobalRefs.main_camera = self

func _process(delta: float) -> void:
	var player_position: = GlobalRefs.player_node.global_position
	var current_sub_world: = GlobalRefs.player_node.sub_world
	if current_sub_world:
		player_position = current_sub_world.world_transform_anchor.global_position \
				+ player_position.rotated(current_sub_world.world_transform_anchor.global_rotation)
	
	var mouse_difference: Vector2 = get_global_mouse_position() - player_position
	var look_direction: Vector2 = mouse_difference.normalized()
	var look_distance: float = min(mouse_difference.length()/look_max_distance / zoom.x,1.0)
			 #0.0 if mouse_difference.length_squared() <= look_threshold*look_threshold else look_offset
	global_position = player_position + (mouse_difference * mouse_weight).limit_length(look_max_distance / zoom.x)
