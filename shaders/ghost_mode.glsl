extern number time;

extern number u_vignette_opacity;
extern number u_sepia_opacity;
extern bool u_correct_ratio;
extern number u_radius;
extern number u_softness;

uniform float shake_power = 0.01;
uniform float shake_rate = 0.1;
uniform float shake_speed = 10.0;
uniform float shake_block_size = 30.5;
uniform float shake_color_rate = 0.004;

float random(float seed) {
    return fract(543.2543 * sin(dot(vec2(seed, seed), vec2(3525.46, -54.3415))));
}

const vec3 SEPIA[2] = vec3[2](
	vec3(1.2, 1.0, 0.8),
	vec3(1.0, 0.95, 0.82)
);

vec4 effect(vec4 color, sampler2D texture, vec2 texCoords, vec2 screenCoords) {
	vec4 texColor = texture2D(texture, texCoords);
	vec2 position = (screenCoords.xy / love_ScreenSize.xy) - vec2(0.5);

    // Glitch Effect ---------------------------------------------------------------------------
    float enable_shift = float(
        random(floor(time * shake_speed))
        < shake_rate
    );

    texCoords.x += (
        random(
            (floor(texCoords.y * shake_block_size) / shake_block_size)
            + time
        ) - 0.5
    ) * shake_power * enable_shift;

    texColor.r = mix(
        texColor.r,
        Texel(texture, texCoords + vec2(shake_color_rate, 0.0)).r,
        enable_shift
    );
    texColor.b = mix(
        texColor.b,
        Texel(texture, texCoords + vec2(-shake_color_rate, 0.0)).b,
        enable_shift
    );
    // ----------------------------------------------------------------------------------------

    // Vignette -------------------------------------------------------------------------------
	if (u_correct_ratio) {
		position.x *= love_ScreenSize.x / love_ScreenSize.y;
	}

	float vignette = smoothstep(
		u_radius,
		u_radius - u_softness,
		length(position)
	);
	texColor.rgb = mix(
		texColor.rgb,
		texColor.rgb * vignette,
		u_vignette_opacity
	);
    // ----------------------------------------------------------------------------------------

    // Sepia ----------------------------------------------------------------------------------
	float grey = dot(texColor.rgb, vec3(0.299, 0.587, 0.114));

	vec3 sepia = vec3(grey);

    sepia *= SEPIA[0];

	texColor.rgb = mix(
		texColor.rgb,
		sepia,
		u_sepia_opacity
	);
    // ----------------------------------------------------------------------------------------

    // Retro Scanlines -----------------------------------------------------------------------
    float scanline = mod(floor(screenCoords.y / 2.0), 2.0);
    texColor.rgb -= vec3(scanline * 0.05);
    // ---------------------------------------------------------------------------------------

	return texColor * color;
}
