class_name NoiseBG extends Sprite2D

func _process(delta: float) -> void:
	if !texture is NoiseTexture2D: return
	var noise: FastNoiseLite = (texture as NoiseTexture2D).noise
	noise.offset.z += delta * 10.0
