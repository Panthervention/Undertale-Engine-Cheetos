varying vec2 v_vTexcoord;
uniform vec2 u_vTexel;
uniform float blur_factor; // New continuous uniform

void main()
{
    vec2 offset = u_vTexel * blur_factor;
    gl_FragColor = (
          texture2D(gm_BaseTexture, v_vTexcoord + vec2( 2.0 * offset.x,            0.0))
        + texture2D(gm_BaseTexture, v_vTexcoord + vec2(-2.0 * offset.x,            0.0))
        + texture2D(gm_BaseTexture, v_vTexcoord + vec2(            0.0, 2.0 * offset.y))
        + texture2D(gm_BaseTexture, v_vTexcoord + vec2(            0.0,-2.0 * offset.y))
        + 2.0*texture2D(gm_BaseTexture, v_vTexcoord + vec2(     offset.x,     offset.y))
        + 2.0*texture2D(gm_BaseTexture, v_vTexcoord + vec2(    -offset.x,     offset.y))
        + 2.0*texture2D(gm_BaseTexture, v_vTexcoord + vec2(     offset.x,    -offset.y))
        + 2.0*texture2D(gm_BaseTexture, v_vTexcoord + vec2(    -offset.x,    -offset.y))
    ) / 12.0;
}
