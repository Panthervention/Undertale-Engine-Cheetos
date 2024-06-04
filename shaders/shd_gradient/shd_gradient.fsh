//
// Simple darken top shader - fragment
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

varying float v_normalized;

void main()
{
    vec4 col = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
 
   col.rgb = col.rgb * v_normalized;
 
   gl_FragColor = col;
}
