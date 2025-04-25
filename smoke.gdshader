shader_type canvas_item;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);

	// Get grayscale brightness (assuming grayscale texture)
	float brightness = tex.r;

	// Strengthen alpha: make dark pixels even more transparent
	// Use a curve to bias transparency toward dark
	float alpha = pow(brightness, 2.5); // ← tweak this for softness

	// Invert brightness to get smoke color (white → black)
	vec3 smoke_color = vec3(1.0 - brightness);

	// Multiply color with alpha to maintain smooth fade
	COLOR = vec4(smoke_color * alpha, alpha * 0.5);
}
