// many thanks to hapenia on godot shaders (https://godotshaders.com/shader/2d-grids/) who created this grid shader! 多谢谢 y que no te ventes a la mierda

shader_type canvas_item;
render_mode blend_mix;

uniform vec2 size = vec2(1280.0, 720.0);
uniform float line_width : hint_range(0, 1) = 0.1;
uniform vec2 offset = vec2(0.0, 0.0);
uniform float grid_size = 16.0;
uniform vec4 grid_color : source_color;

void fragment() {
	COLOR = grid_color;
	vec2 uv = (offset / size) + UV;
	vec2 r = mod(size * uv, vec2(grid_size));
	vec2 lines = smoothstep(1.0 - line_width, 1, r / vec2(grid_size));
	float alpha = dot(lines, vec2(1.0, 1.0));
	COLOR.a = alpha;
}