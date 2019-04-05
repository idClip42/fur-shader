﻿fixed4 _Color;
sampler2D _MainTex;
sampler2D _Normals;
half _NormalStr;
sampler2D _NoiseTex;
sampler2D _StrandTex;
uniform float _StrandColorStrength;

half _AO;
half _Metallic;

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

struct Input {
	float2 uv_MainTex;
	float2 uv_NoiseTex;
	float2 uv_SecondLayerNoise;
	float3 viewDir;
};