shader_type canvas_item;

uniform sampler2D foam_tex : source_color, repeat_enable;
uniform vec2 wave_amp = vec2(0.01);
uniform vec2 wave_freq = vec2(0.5);
uniform sampler2D refract_tex : source_color, repeat_enable;
uniform float foam_width = 0.3;
uniform float foam_speed = 0.5;
uniform vec2 foam_ratio = vec2(1.0);

void fragment() {
	vec2 uv = UV;
	uv.r += sin(uv.g * TAU + TIME * wave_freq.r) * wave_amp.r;
	uv.g += sin(uv.r * TAU + TIME * wave_freq.g) * wave_amp.g;
	
	vec4 foam_color = texture(foam_tex, uv);
	if (foam_color.r < 1.0 + (sin(TIME * foam_speed + uv.g * TAU * foam_ratio.g + uv.r * TAU * foam_ratio.r) - 1.0 ) * foam_width / 2.0 ) {
		foam_color = vec4(0.0);
	}else {
		foam_color = vec4(1.0);
	}
	vec4 refract_color = texture(refract_tex, uv);
	COLOR = foam_color + refract_color ;
}
 
