// shdKawaseUp.fsh
varying vec2 v_vTexcoord;
uniform vec2 u_vTexel;
uniform float blur_factor;

void main()
{
    vec2 offset = u_vTexel * blur_factor;
    gl_FragColor = (
          4.0 * texture2D(gm_BaseTexture, v_vTexcoord)
        + texture2D(gm_BaseTexture, v_vTexcoord + vec2( offset.x, 0.0))
        + texture2D(gm_BaseTexture, v_vTexcoord + vec2(-offset.x, 0.0))
        + texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.0,  offset.y))
        + texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.0, -offset.y))
    ) / 8.0;
}
