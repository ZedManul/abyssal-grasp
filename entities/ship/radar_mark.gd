class_name RadarMark extends Polygon2D

@export var active: bool = true
@export var directional: bool = false

func _ready() -> void:
	add_to_group("RadarMarks", true)
	hide()
