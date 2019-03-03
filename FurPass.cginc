void surf (Input IN, inout SurfaceOutputStandard o)
{
	half perc = GetPercentage();

    o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb * _Color *
        lerp(1,
        tex2D (_StrandTex, fixed2(perc, 0.5f)),
        _StrandColorStrength);
    
    o.Alpha = tex2D (_NoiseTex, IN.uv_NoiseTex).r;
	#ifdef _FADE_ON
		o.Alpha = step(lerp(_Cutoff, _CutoffEnd, perc), o.Alpha);
        o.Alpha *= 1 - 2 * _EdgeFade * (1 - (dot(IN.viewDir, o.Normal) * (1 - (perc * perc))));
		o.Albedo *= o.Alpha;
		clip(o.Alpha - 0.01);
	#else
		clip(o.Alpha - lerp(_Cutoff, _CutoffEnd, perc));
	#endif

	o.Normal = lerp(o.Normal, UnpackNormal(tex2D(_Normals, IN.uv_MainTex)), _NormalStr);

	o.Occlusion = lerp(1, FUR_MULTIPLIER, _AO);
}