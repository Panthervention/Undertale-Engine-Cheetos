//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;
//
uniform vec4 u_rect;
uniform sampler2D u_mask;
uniform int u_maskEnable;

void main()
{
	if (u_maskEnable != 0)
	{
	    gl_FragColor = v_vColour
	        * texture2D(gm_BaseTexture, v_vTexcoord)
	        * texture2D(u_mask, (v_vPosition.xy - u_rect.xy) / u_rect.zw).r; // u_mask uses surface_r8unorm, so only use red channel
	}
	else
		gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
}
