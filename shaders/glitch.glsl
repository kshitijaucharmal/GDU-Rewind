extern number time;

uniform float shake_power = 0.01;
uniform float shake_rate = 0.1;
uniform float shake_speed = 10.0;
uniform float shake_block_size = 30.5;
uniform float shake_color_rate = 0.004;

float random(float seed)
{
    return fract(543.2543 * sin(dot(vec2(seed, seed), vec2(3525.46, -54.3415))));
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec2 fixed_uv = texture_coords;
    vec4 pixel_color = Texel(texture, fixed_uv);

    float enable_shift = float(
        random(floor(time * shake_speed))
        < shake_rate
    );

    fixed_uv.x += (
        random(
            (floor(texture_coords.y * shake_block_size) / shake_block_size)
            + time
        ) - 0.5
    ) * shake_power * enable_shift;

    pixel_color.r = mix(
        pixel_color.r,
        Texel(texture, fixed_uv + vec2(shake_color_rate, 0.0)).r,
        enable_shift
    );
    pixel_color.b = mix(
        pixel_color.b,
        Texel(texture, fixed_uv + vec2(-shake_color_rate, 0.0)).b,
        enable_shift
    );

    // Apply simple scanline effect
    float scanline = mod(floor(screen_coords.y / 2.0), 2.0);
    pixel_color.rgb -= vec3(scanline * 0.03);


    return pixel_color * color;
}

