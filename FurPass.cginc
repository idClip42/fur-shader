#pragma target 3.0

fixed4 _Color;
sampler2D _MainTex;
half _AlphaMult;
sampler2D _NoiseTex;
half _NoiseMult;
half _Smoothness;
half _Metallic;
half _AOColor;
half _AO;

uniform float _FurLength;
uniform float _Cutoff;
uniform float _CutoffEnd;
uniform float _EdgeFade;

uniform fixed3 _Gravity;
uniform fixed _GravityStrength;

sampler2D _StrandTex;
uniform float _StrandColorStrength;

half _Fade;

void vert (inout appdata_full v)
{
	fixed3 direction = lerp(v.normal, _Gravity * _GravityStrength + v.normal * (1-_GravityStrength), FUR_MULTIPLIER);
	v.vertex.xyz += direction * _FurLength * FUR_MULTIPLIER * v.color.a;
}

struct Input {
	float2 uv_MainTex;
	float2 uv_NoiseTex;
	float3 viewDir;
};

void surf (Input IN, inout SurfaceOutputStandard o)
{
	fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;

	o.Albedo = c.rgb *
		lerp(1,
			tex2D (_StrandTex, fixed2(FUR_MULTIPLIER, 0.5f)),
			_StrandColorStrength);
	o.Alpha = lerp(1, c.a, _AlphaMult);

	o.Alpha *= lerp(1, (tex2D (_NoiseTex, IN.uv_NoiseTex)).r, _NoiseMult);

	#ifdef _FADE_ON
		o.Alpha = step(lerp(_Cutoff, _CutoffEnd, FUR_MULTIPLIER), o.Alpha);
		float alpha = dot(IN.viewDir, o.Normal);
		alpha *= 1 - (FUR_MULTIPLIER * FUR_MULTIPLIER);
		alpha = 1 - 2 * _EdgeFade * (1 - alpha);
		o.Alpha *= alpha;
	#else
		clip(o.Alpha - lerp(_Cutoff, _CutoffEnd, FUR_MULTIPLIER));
	#endif



	o.Metallic = _Metallic * FUR_MULTIPLIER * FUR_MULTIPLIER;
	o.Smoothness = _Smoothness * FUR_MULTIPLIER * FUR_MULTIPLIER;

	o.Occlusion = lerp(1, o.Albedo, _AOColor) * _AO;
}