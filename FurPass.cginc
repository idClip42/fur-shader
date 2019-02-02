//#pragma target 3.0

fixed4 _Color;
sampler2D _MainTex;
sampler2D _Normals;
half _NormalStr;
sampler2D _NoiseTex;
sampler2D _StrandTex;
uniform float _StrandColorStrength;

half _AO;

uniform float _FurLength;
uniform float _FurLengthMin;
uniform float _ThicknessCurve;
uniform float _Offset;
uniform float _Cutoff;
uniform float _CutoffEnd;
uniform float _EdgeFade;

uniform fixed4 _Gravity;

uniform half _NormInf;
uniform half _NormInfTip;

sampler2D _WindCloud;
fixed4 _WindDir;


half3 GetMapNormal(inout appdata_full v)
{
	half3 wNormal = v.normal;
    half3 wTangent = v.tangent.xyz;
    half3 wBitangent = cross(wNormal, wTangent) * v.tangent.w;
    half3 tnormal = (tex2Dlod(_Normals, v.texcoord) - 0.5f) * 2;
    return half3(
        dot(half3(wTangent.x, wBitangent.x, wNormal.x), tnormal),
        dot(half3(wTangent.y, wBitangent.y, wNormal.y), tnormal),
        dot(half3(wTangent.z, wBitangent.z, wNormal.z), tnormal));
}

half GetPercentage()
{
    return lerp(FUR_MULTIPLIER, 1 - pow(1-FUR_MULTIPLIER,2), _ThicknessCurve);
}

void vert (inout appdata_full v)
{
    half3 mapNormal = GetMapNormal(v);
	fixed3 vNormal = lerp(v.normal, mapNormal, _NormInf);
    
    half timeVal = fmod(_Time.y * _WindDir.w, 1);
	fixed3 forceDir = lerp(
        lerp(_Gravity.xyz, mapNormal, _NormInfTip) * _Gravity.w, 
        _WindDir.xyz, 
        tex2Dlod(
            _WindCloud, 
            half4(v.texcoord.x + timeVal, timeVal, v.texcoord.z, v.texcoord.w)).x);
            
	half perc = GetPercentage();

	v.vertex.xyz += 
        v.normal * _Offset + 
        lerp(
            vNormal, 
            (forceDir) + vNormal * (1-_Gravity.w), 
            perc) * 
        lerp(_FurLengthMin, _FurLength, tex2Dlod(_MainTex, v.texcoord).w) * 
        perc * 
        v.color.a;
}

struct Input {
	float2 uv_MainTex;
	float2 uv_NoiseTex;
	float2 uv_SecondLayerNoise;
	float3 viewDir;
};

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