
fixed4      _Color;
sampler2D   _MainTex;
half        _AO;

sampler2D   _Normals;
half        _NormalStr;

sampler2D   _StrandTex;
half        _StrandTexStr;

sampler2D   _NoiseTex;
half        _NoiseScale;
half        _EdgeFade;

half        _FurLength;
half        _FurLengthMin;

sampler2D   _HeightMap;
half        _Offset;
half        _TipOffset;

fixed4      _Gravity;
sampler2D   _TangentMap;
half        _NormInf;

sampler2D   _WindCloud;
fixed4      _WindDir;

struct Input {
	float2  uv_MainTex;
	float2  uv_NoiseTex;
	float3  viewDir;
};