shader_type canvas_item;

uniform vec3 blanco_base : source_color = vec3(1.0, 1.0, 1.0);
uniform vec3 cambiar_blanco : source_color = vec3(1.0, 1.0, 1.0);

uniform float edge = 0.005;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 color_original_textura = texture(TEXTURE, UV);
    vec3 color_actual = color_original_textura.rgb;

    float longitud_vector_color = length(color_actual - blanco_base);
    float factor_interpolacion_color = step(longitud_vector_color, edge);
	vec3 color_nuevo = mix(color_actual, cambiar_blanco, factor_interpolacion_color);
	COLOR.rgb = color_nuevo;
	//COLOR = texture(TEXTURE, UV) * color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
