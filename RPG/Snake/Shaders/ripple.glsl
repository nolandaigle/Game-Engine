uniform float time

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = fragCoord.xy / resolution.xy;
  float sepoffset = 0.005*cos(time*3.0);
  if (uv.y > 0.3 + sepoffset)// is air - no reflection or effect
  {
      fragColor = texture2D(texture, vec2(uv.x, -uv.y));
  }
  else
  {
      // Compute the mirror effect.
        float xoffset = 0.005*cos(time*3.0+200.0*uv.y);
        //float yoffset = 0.05*(1.0+cos(time*3.0+50.0*uv.y));
        float yoffset = ((0.3 - uv.y)/0.3) * 0.05*(1.0+cos(time*3.0+50.0*uv.y));
      vec4 color = texture2D(texture, vec2(uv.x+xoffset , -1.0*(0.6 - uv.y+ yoffset)));
      // 
      vec4 finalColor = vec4(mix(color.rgb, overlayColor, 0.25), 1.0);
      fragColor = color;
  }
}