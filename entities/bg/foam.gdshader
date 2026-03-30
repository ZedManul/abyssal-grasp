shader_type canvas_item;

uniform sampler2D foam_tex : source_color, repeat_enable;

void fragment() {
	COLOR = texture(foam_tex, UV);
	
	float range = 0.3; 
	COLOR.a = 1.0;
	
	if (COLOR.r < 1.0 + (sin(TIME) - 1.0 ) * range / 2.0 ) {
		discard;
	}
	COLOR.rgb = vec3(1.0);
	
}
 
