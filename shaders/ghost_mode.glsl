
extern number u_vignette_opacity;
extern number u_sepia_opacity;
extern bool u_correct_ratio;
extern number u_radius;
extern number u_softness;

const vec3 SEPIA[2] = vec3[2](
	vec3(1.2, 1.0, 0.8),
	vec3(1.0, 0.95, 0.82)
);

vec4 effect(vec4 color, sampler2D texture, vec2 texCoords, vec2 screenCoords) {
	vec4 texColor = texture2D(texture, texCoords);
	vec2 position = (screenCoords.xy / love_ScreenSize.xy) - vec2(0.5);

	if (u_correct_ratio) {
		position.x *= love_ScreenSize.x / love_ScreenSize.y;
	}

	float vignette = smoothstep(
		u_radius,
		u_radius - u_softness,
		length(position)
	);

	// NTSC weights
	float grey = dot(texColor.rgb, vec3(0.299, 0.587, 0.114));

	vec3 sepia = vec3(grey);

    sepia *= SEPIA[0];

	texColor.rgb = mix(
		texColor.rgb,
		sepia,
		u_sepia_opacity
	);

	texColor.rgb = mix(
		texColor.rgb,
		texColor.rgb * vignette,
		u_vignette_opacity
	);

	return texColor * color;
}
