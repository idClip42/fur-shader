#pragma target 3.0

sampler2D _MainTex;
sampler2D _Normals;

struct Input {
	float2 uv_MainTex;
	float3 viewDir;
};

half _NormalStr;
half _Smoothness;
half _Metallic;
fixed4 _Color;
half _AO;
half _AOColor;

sampler2D _StrandTex;
uniform float _StrandColorStrength;

void surf (Input IN, inout SurfaceOutputStandard o) {
	o.Albedo = (tex2D (_MainTex, IN.uv_MainTex) * _Color).rgb * 
		lerp(1, 
		tex2D (_StrandTex, fixed2(0, 0.5f)), 
		_StrandColorStrength);
	o.Normal = lerp(o.Normal, UnpackNormal(tex2D(_Normals, IN.uv_MainTex)), _NormalStr);
	o.Metallic = 0;
	o.Smoothness = 0;
	o.Alpha = 1;
	o.Occlusion = lerp(1, o.Albedo, _AOColor) * _AO;
}