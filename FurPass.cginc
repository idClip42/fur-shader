// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

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
uniform float _Offset;
uniform float _Cutoff;
uniform float _CutoffEnd;
uniform float _EdgeFade;
uniform half _NormInf;
uniform half _NormInfTip;

uniform fixed3 _Gravity;
uniform fixed _GravityStrength;

sampler2D _StrandTex;
uniform float _StrandColorStrength;

sampler2D _WindCloud;
fixed4 _WindDir;

half _Fade;

// Is this necessary?
#include "UnityCG.cginc"

//half3 GetMapNormal(inout appdata_full v)
//{
////	fixed3 normals = tex2Dlod(_Normals, v.texcoord);
//	fixed3 normals = UnpackNormal(tex2Dlod(_Normals, v.texcoord));
//    half3 wNormal = UnityObjectToWorldNormal(v.normal.xyz);
//    half3 wTangent = UnityObjectToWorldDir(v.tangent.xyz);
//    half3 wBitangent = cross(wNormal, wTangent) * v.tangent.w * unity_WorldTransformParams.w;
//	return half3(dot(half3(wTangent.x, wBitangent.x, wNormal.x), normals), dot(half3(wTangent.y, wBitangent.y, wNormal.y), normals), dot(half3(wTangent.z, wBitangent.z, wNormal.z), normals));
//}

//half3 GetMapNormal(inout appdata_full v)
//{
//	fixed3 normalMap = UnpackNormal(tex2Dlod(_Normals, v.texcoord));
////	fixed3 normalMap = tex2Dlod(_Normals, v.texcoord);
////	normalMap.r = normalMap.r * 2 - 1;
////	normalMap.g = normalMap.g * 2 - 1;
////	normalMap.b = normalMap.b * 2 - 1;
//    float3 oSWorldNormal = mul((float3x3)unity_ObjectToWorld, v.normal);
//    float4 oTangent = mul(unity_ObjectToWorld, v.tangent);
//
//    float3 tangent = normalize(oTangent.xyz);
//    float3 normal = normalize(oSWorldNormal);
//    float3 binormal = normalize(cross(normal, tangent) * oTangent.w);
//    float3x3 tangentToWorld = transpose(float3x3(tangent, binormal, normal));
//    float3 dir = mul(tangentToWorld, normalMap);
//
//    return dir;
//}

half3 GetMapNormal(inout appdata_full v)
{
//	half3 wNormal = UnityObjectToWorldNormal(v.normal);
//    half3 wTangent = UnityObjectToWorldDir(v.tangent.xyz);
	half3 wNormal = v.normal;
    half3 wTangent = v.tangent.xyz;

    half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
    half3 wBitangent = cross(wNormal, wTangent) * tangentSign;

    half3 tspace0 = half3(wTangent.x, wBitangent.x, wNormal.x);
   	half3 tspace1 = half3(wTangent.y, wBitangent.y, wNormal.y);
   	half3 tspace2 = half3(wTangent.z, wBitangent.z, wNormal.z);

//	half3 tnormal = UnpackNormal(tex2Dlod(_Normals, v.texcoord));
	half3 tnormal = tex2Dlod(_Normals, v.texcoord);// * 2;
	tnormal -= 0.25f;	// I don't understand what's going on here
	tnormal *= 2;
//	tnormal.x -= 1;
//	tnormal.y -= 1;
//	tnormal.z -= 1;
//	tnormal *= 5;

	half3 worldNormal;
    worldNormal.x = dot(tspace0, tnormal);
    worldNormal.y = dot(tspace1, tnormal);
    worldNormal.z = dot(tspace2, tnormal);

    return worldNormal;
}

void vert (inout appdata_full v)
{
	fixed3 forceDir = _Gravity;

	fixed3 n = v.normal;
	#ifdef _NORMINFENABLE_ON
		half3 mapNormal = GetMapNormal(v);
		n = lerp(n, mapNormal, _NormInf);
		forceDir = lerp(forceDir, mapNormal, _NormInfTip);
	#else
	#endif

	forceDir *= _GravityStrength;

	#ifdef _WIND_ON
		half t = fmod(_Time.y * _WindDir.w, 1);
		half4 pt = half4(v.texcoord.x + t/3, t, v.texcoord.z, v.texcoord.w);
		half wind = tex2Dlod(_WindCloud, pt).x;
		forceDir = lerp(forceDir, _WindDir.xyz, wind);
	#else
	#endif

	fixed3 direction = lerp(n, forceDir + n * (1-_GravityStrength), FUR_MULTIPLIER);
	v.vertex.xyz += v.normal * _Offset + direction * _FurLength * FUR_MULTIPLIER * v.color.a;
}

struct Input {
	float2 uv_MainTex;
	float2 uv_NoiseTex;
	float3 viewDir;
};

void surf (Input IN, inout SurfaceOutputStandard o)
{
	fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;


	o.Metallic = _Metallic * FUR_MULTIPLIER * FUR_MULTIPLIER;
	o.Smoothness = _Smoothness * FUR_MULTIPLIER * FUR_MULTIPLIER;


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
		o.Albedo *= o.Alpha;
		o.Smoothness *= o.Alpha;
		clip(o.Alpha - 0.01);
	#else
		clip(o.Alpha - lerp(_Cutoff, _CutoffEnd, FUR_MULTIPLIER));
	#endif

	o.Normal = lerp(o.Normal, UnpackNormal(tex2D(_Normals, IN.uv_MainTex)), _NormalStr);

	o.Occlusion = lerp(1, o.Albedo, _AOColor) * _AO;
}