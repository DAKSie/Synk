shader_type canvas_item;
render_mode unshaded;

uniform sampler2D screen_texture: hint_screen_texture;
uniform vec2 screen_size;

// Curvature
uniform float curvature : hint_range(1.0, 20.0) = 7.0;

// Scanlines
uniform float scanline_intensity : hint_range(0.0, 0.5) = 0.15;
uniform float scanline_density : hint_range(1.0, 5.0) = 2.0;

// Vignette
uniform float vignette_intensity : hint_range(0.0, 1.0) = 0.4;
uniform float vignette_roundness : hint_range(0.0, 2.0) = 1.0;

// Color effects
uniform float color_bleed : hint_range(0.0, 1.0) = 0.1;
uniform float brightness : hint_range(0.5, 1.5) = 1.1;
uniform float contrast : hint_range(0.5, 1.5) = 1.05;
uniform float saturation : hint_range(0.0, 2.0) = 1.1;

// Glow
uniform float glow_intensity : hint_range(0.0, 1.0) = 0.3;

// RGB shift (misalignment)
uniform float rgb_shift : hint_range(0.0, 0.01) = 0.001;

void fragment() {
    // Convert vertex position to screen UV
    vec2 screen_uv = VERTEX / screen_size;
    vec2 centered_uv = screen_uv * 2.0 - 1.0;
    
    // Apply curvature
    vec2 uv_offset = centered_uv.yx / curvature;
    vec2 warped_uv = centered_uv + centered_uv * uv_offset * uv_offset;
    
    // Convert back to 0-1
    vec2 final_uv = (warped_uv * 0.5) + 0.5;
    
    // Sample with RGB shift
    vec3 color;
    color.r = texture(screen_texture, final_uv + vec2(rgb_shift, 0.0)).r;
    color.g = texture(screen_texture, final_uv).g;
    color.b = texture(screen_texture, final_uv - vec2(rgb_shift, 0.0)).b;
    
    // Apply color bleeding
    vec3 color_bleed_effect;
    color_bleed_effect.r = texture(screen_texture, final_uv + vec2(0.002, 0.0)).r;
    color_bleed_effect.g = texture(screen_texture, final_uv).g;
    color_bleed_effect.b = texture(screen_texture, final_uv - vec2(0.002, 0.0)).b;
    color = mix(color, color_bleed_effect, color_bleed);
    
    // Apply scanlines
    float scanline = sin(final_uv.y * screen_size.y * scanline_density) * 0.5 + 0.5;
    scanline = pow(scanline, 1.5) * scanline_intensity + (1.0 - scanline_intensity);
    color *= scanline;
    
    // Add phosphor glow
    vec3 glow = color;
    glow += texture(screen_texture, final_uv + vec2(0.002, 0.0)).rgb * 0.3;
    glow += texture(screen_texture, final_uv - vec2(0.002, 0.0)).rgb * 0.3;
    color = mix(color, glow, glow_intensity);
    
    // Apply vignette
    float dist = length(centered_uv * vec2(1.0, vignette_roundness));
    float vignette = 1.0 - dist * vignette_intensity;
    vignette = clamp(vignette, 0.0, 1.0);
    color *= vignette;
    
    // Apply brightness and contrast
    color = (color - 0.5) * contrast + 0.5;
    color *= brightness;
    
    // Apply saturation
    float gray = dot(color, vec3(0.299, 0.587, 0.114));
    color = mix(vec3(gray), color, saturation);
    
    // Add subtle flicker (optional)
    float flicker = 0.98 + sin(FRAGCOORD.y * 5.0 + TIME * 8.0) * 0.1;
    color *= flicker;
    
    COLOR = vec4(color, 1.0);
}