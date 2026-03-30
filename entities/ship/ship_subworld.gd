class_name ShipSubWorld extends SubViewportContainer


@export var world_transform_anchor: Node2D
@export var sub_world_camera: Camera2D
@export var sub_world_vp: SubViewport
#@export var scaling_factor: float = 8.0


func _ready() -> void:
	if world_transform_anchor is VisibleOnScreenNotifier2D:
		world_transform_anchor.screen_entered.connect(show)
		world_transform_anchor.screen_exited.connect(hide)


func _process(_delta: float) -> void:
	update_cam_coords.call_deferred()


func update_cam_coords() -> void:
	var mc: = GlobalRefs.main_camera
	if !mc: return
	var mc_size: Vector2 = mc.get_viewport_rect().size/mc.zoom
	size = DisplayServer.window_get_size()
	var scaling_factor: Vector2 = size/mc_size
	scale = Vector2.ONE/(scaling_factor)
	global_position = mc.get_screen_center_position()-mc_size/2.0
	rotation = -get_parent().global_rotation
	
	if !sub_world_camera: return
	sub_world_camera.global_position = (mc.get_screen_center_position() \
			- world_transform_anchor.global_position).rotated(-world_transform_anchor.global_rotation)
	sub_world_camera.global_rotation = -world_transform_anchor.global_rotation
	sub_world_camera.zoom = mc.zoom
