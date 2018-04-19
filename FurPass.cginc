#pragma target 3.0

fixed4 _Color;
sampler2D _MainTex;
sampler2D _Normals;
half _NormalStr;
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
uniform half _NormInf;

uniform fixed3 _Gravity;
uniform fixed _GravityStrength;

sampler2D _StrandTex;
uniform float _StrandColorStrength;

sampler2D _WindCloud;
fixed4 _WindDir;

half _Fade;

#include "UnityCG.cginc"

half3 GetMapNormal(inout appdata_full v)
{
	fixed3 normals = tex2Dlod(_Normals, v.texcoord);
    half3 wNormal = UnityObjectToWorldNormal(v.normal.xyz);
    half3 wTangent = UnityObjectToWorldDir(v.tangent.xyz);
    half3 wBitangent = cross(wNormal, wTangent) * v.tangent.w * unity_WorldTransformParams.w;
	return half3(dot(half3(wTangent.x, wBitangent.x, wNormal.x), normals), dot(half3(wTangent.y, wBitangent.y, wNormal.y), normals), dot(half3(wTangent.z, wBitangent.z, wNormal.z), normals));
}

void vert (inout appdata_full v)
{
	half t = fmod(_Time.y * _WindDir.w, 1);
//	half4 pt = v.texcoord;
//	pt.y = t;
//	pt.x = v.texcoord.x + t/3;
	half4 pt = half4(v.texcoord.x + t/3, t, v.texcoord.z, v.texcoord.w);
	half wind = tex2Dlod(_WindCloud, pt).x;

	fixed3 forceDir = lerp(_Gravity * _GravityStrength, _WindDir.xyz, wind);

	fixed3 n = lerp(v.normal, GetMapNormal(v), _NormInf);

	fixed3 direction = lerp(n, forceDir + n * (1-_GravityStrength), FUR_MULTIPLIER);
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

	o.Normal = lerp(o.Normal, UnpackNormal(tex2D(_Normals, IN.uv_MainTex)), _NormalStr);


	o.Metallic = _Metallic * FUR_MULTIPLIER * FUR_MULTIPLIER;
	o.Smoothness = _Smoothness * FUR_MULTIPLIER * FUR_MULTIPLIER;

	o.Occlusion = lerp(1, o.Albedo, _AOColor) * _AO;
}