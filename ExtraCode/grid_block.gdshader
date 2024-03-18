shader_type spatial;

// Cube size is hard coded here, bad practice, might fix later
uniform float inner_distance_threshold : hint_range(-1, 1) = 0.1;
uniform vec4 inner_color : source_color;
uniform vec4 outer_color : source_color;

varying vec3 frag_pos;

varying vec4 color_options[3]; 

void vertex() {
	frag_pos = VERTEX.xyz;
}

void fragment() {
	// Create booleans for bounds
	bool x = abs(frag_pos.x) <= inner_distance_threshold;
	bool y = abs(frag_pos.y) <= inner_distance_threshold;
	bool z = abs(frag_pos.z) <= inner_distance_threshold;
    
	// Check if the fragment is near an edge
    if ( ( x && y ) || (x && z) || (y && z) ) {
        // Not near an edge, inner color
        ALBEDO = inner_color.xyz;
    } else {
        // Near an edge, color black
		ALBEDO = outer_color.xyz;
    }
}

//float random (vec2 uv) {
    //return fract(sin(dot(uv.xy,
        //vec2(12.9898,78.233))) * 43758.5453123);
//}