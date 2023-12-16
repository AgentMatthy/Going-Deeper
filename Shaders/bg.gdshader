shader_type canvas_item;

uniform sampler2D texture2;
uniform sampler2D color_texture;
uniform vec2 scroll_offset = vec2(0.1,0.1);
uniform vec2 scroll_offset2 = vec2(0.1,0.1);
uniform vec2 center = vec2(0.5,0.5);
uniform float amount = 0.3;

void fragment(){
	vec2 disp = normalize(UV - center);
	float texture_color1 = texture(TEXTURE,(UV-disp) +scroll_offset*TIME).r;
	float texture_color2 = texture(texture2,UV + scroll_offset2*TIME).r;
	float energy = texture_color1*texture_color2 - amount;
	vec4 color = texture(color_texture,vec2(energy));
	COLOR = color;
}