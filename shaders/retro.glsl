vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec4 tex_color = Texel(texture, texture_coords);

    // Apply simple scanline effect
    float scanline = mod(floor(screen_coords.y / 2.0), 2.0);
    tex_color.rgb -= vec3(scanline * 0.03);

    return tex_color * color;
}
