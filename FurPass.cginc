//#pragma target 3.0

fixed4 _Color;
sampler2D _MainTex;
sampler2D _Normals;
half _NormalStr;
sampler2D _NoiseTex;
sampler2D _StrandTex;
uniform float _StrandColorStrength;

half _Smoothness;
half _Metallic;
half _AO;

uniform float _FurLength;
uniform float _FurLengthMin;
uniform float _ThicknessCurve;
uniform float _Offset;
uniform float _Cutoff;
uniform float _CutoffEnd;
uniform float _EdgeFade;

uniform float _FirstLayer;
fixed4 _SecondLayerColor;
sampler2D _SecondLayerTex;
sampler2D _SecondLayerMask;
sampler2D _SecondLayerNoise;
sampler2D _SecondLayerStrandTex;
uniform float _SecondLayerStrandColorStrength;

uniform fixed3 _Gravity;
uniform fixed _GravityStrength;

uniform half _NormInf;
uniform half _NormInfTip;

sampler2D _WindCloud;
fixed4 _WindDir;


half3 GetMapNormal(inout appdata_full v)
{
	half3 wNormal = v.normal;
    half3 wTangent = v.tangent.xyz;

    half tangentSign = v.tangent.w;
    half3 wBitangent = cross(wNormal, wTangent) * tangentSign;

    half3 tspace0 = half3(wTangent.x, wBitangent.x, wNormal.x);
   	half3 tspace1 = half3(wTangent.y, wBitangent.y, wNormal.y);
   	half3 tspace2 = half3(wTangent.z, wBitangent.z, wNormal.z);

	half3 tnormal = tex2Dlod(_Normals, v.texcoord);
	tnormal -= 0.5f;
	tnormal *= 2;

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

	//half furLength = _FurLength * tex2Dlod(_MainTex, v.texcoord).w;
    half furLength = lerp(_FurLengthMin, _FurLength, tex2Dlod(_MainTex, v.texcoord).w);
	half perc = lerp(FUR_MULTIPLIER, 1 - pow(1-FUR_MULTIPLIER,2), _ThicknessCurve);

	fixed3 direction = lerp(n, forceDir + n * (1-_GravityStrength), perc);
	v.vertex.xyz += v.normal * _Offset + direction * furLength * perc * v.color.a;
}

struct Input {
	float2 uv_MainTex;
	float2 uv_NoiseTex;
	float2 uv_SecondLayerNoise;
	float3 viewDir;
};

void surf (Input IN, inout SurfaceOutputStandard o)
{

	half perc = lerp(FUR_MULTIPLIER, 1 - pow(1-FUR_MULTIPLIER,2), _ThicknessCurve);


	o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb * _Color;
	o.Albedo *= lerp(1,
		tex2D (_StrandTex, fixed2(perc, 0.5f)),
		_StrandColorStrength);


	o.Metallic = _Metallic * perc * perc;
	o.Smoothness = _Smoothness * perc * perc;


	
	o.Alpha = tex2D (_NoiseTex, IN.uv_NoiseTex).r;

    
    
	//#ifdef _SECONDLAYER_ON
	//	// Get strength of second layer via noise and mask
	//	fixed3 layerStr = tex2D (_SecondLayerNoise, IN.uv_SecondLayerNoise).rgb;
	//	layerStr *= tex2D (_SecondLayerMask, IN.uv_MainTex).a;

	//	// Get base color and gradent color of second layer
	//	fixed3 c2 = tex2D (_SecondLayerTex, IN.uv_MainTex).rgb * _SecondLayerColor;
	//	c2 *= lerp(1, tex2D (_SecondLayerStrandTex, fixed2(perc, 0.5f)), _SecondLayerStrandColorStrength);

	//	// Apply second layer
	//	o.Alpha = lerp(o.Alpha * _FirstLayer, layerStr, layerStr);
	//	o.Albedo = lerp(o.Albedo, c2, layerStr);
	//#else
	//#endif
    


	#ifdef _FADE_ON
		o.Alpha = step(lerp(_Cutoff, _CutoffEnd, perc), o.Alpha);
		float alpha = dot(IN.viewDir, o.Normal);
		alpha *= 1 - (perc * perc);
		alpha = 1 - 2 * _EdgeFade * (1 - alpha);
		o.Alpha *= alpha;
		o.Albedo *= o.Alpha;
		o.Smoothness *= o.Alpha;
		clip(o.Alpha - 0.01);
	#else
		clip(o.Alpha - lerp(_Cutoff, _CutoffEnd, perc));
	#endif

	o.Normal = lerp(o.Normal, UnpackNormal(tex2D(_Normals, IN.uv_MainTex)), _NormalStr);

	o.Occlusion = lerp(1, FUR_MULTIPLIER, _AO);
}