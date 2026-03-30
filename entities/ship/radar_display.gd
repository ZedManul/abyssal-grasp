class_name RadarDisplay extends Node2D

@export var radar_scale: Vector2 = Vector2(0.1,0.1)
@export var world_anchor: Node2D
@export var inherit_world_anchor_rotation: bool = true
@export_range(-180, 180, 1.0, "radians_as_degrees") var anchor_rotation_offset: float = 0.0
@export var anchor_position_offset: Vector2 = Vector2(0.5,0.5)
var viewport_offset: Vector2


func _ready() -> void:
	viewport_offset = get_viewport_rect().size

func _process(delta: float) -> void:
	if get_viewport().get_parent().is_visible_in_tree():
		queue_redraw()

func _draw() -> void:
	
	for i:RadarMark in get_tree().get_nodes_in_group("RadarMarks"):
		if !i.active: continue
		var rotation_offset: float = anchor_rotation_offset - (world_anchor.global_rotation if inherit_world_anchor_rotation else 0.0)
		draw_set_transform(
				viewport_offset * anchor_position_offset \
					+ (i.global_position - world_anchor.global_position).rotated(rotation_offset) * radar_scale, 
				i.global_rotation + rotation_offset if i.directional else 0.0
			)
		draw_colored_polygon(i.polygon,i.color,i.uv,i.texture)
