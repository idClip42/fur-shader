void surf (Input IN, inout SURF_OUTPUT o)
{
    const half BASE_CUTOFF = 0.0f;
    const half TIP_CUTOFF = 0.95f;

    o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb * _Color *
        lerp(1,
        tex2D (_StrandTex, fixed2(FUR_MULTIPLIER, 0.5f)),
        _StrandTexStr);
    
    IN.uv_NoiseTex *= _NoiseScale;
    o.Alpha = tex2D (_NoiseTex, IN.uv_NoiseTex).r;
    
	#ifdef _FADE_ON
		o.Alpha = step(lerp(BASE_CUTOFF, TIP_CUTOFF, FUR_MULTIPLIER), o.Alpha) *
            (1 - 2 * _EdgeFade * 
                (1 - (dot(IN.viewDir, o.Normal) * 
                (1 - (FUR_MULTIPLIER * FUR_MULTIPLIER)))));
		clip(o.Alpha - 0.01);
	#else
		clip(o.Alpha - lerp(BASE_CUTOFF, TIP_CUTOFF, FUR_MULTIPLIER));
	#endif

	o.Normal = lerp(
        o.Normal, 
        UnpackNormal(tex2D(_Normals, IN.uv_MainTex)), 
        _NormalStr);

	o.Occlusion = lerp(1, FUR_MULTIPLIER, _AO);
}