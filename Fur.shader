Shader "Fur/Fur" {
	Properties {
        [Toggle] _Fade ("Fade Render", Float) = 0.0

		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo", 2D) = "white" {}
		_Normals ("Normal Map", 2D) = "bump" {}
		_NormalStr ("Normal Strength", Range(0,1)) = 1
		_AlphaMult ("Alpha Strength", Range(0,1)) = 1
		_NoiseTex ("Noise", 2D) = "white" {}
		_NoiseMult ("Noise Strength", Range(0,1)) = 1
		_Smoothness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_AO("Ambient Occlusion Strength", Range(0,1)) = 1.0
		_AOColor("Ambient Occlusion From Color", Range(0,1)) = 0.0

		_FurLength ("Fur Length", Range (.0002, 1)) = 0.1
		_Cutoff ("Alpha cutoff", Range(0,1)) = 0
		_CutoffEnd ("Alpha cutoff end", Range(0,1)) = 0.5
		_EdgeFade ("Edge fade", Range(0,1)) = 0.5

		_Gravity ("Gravity direction", Vector) = (0,0,1,0)
		_GravityStrength ("Gravity strength", Range(0,1)) = 0.25

		_StrandTex ("Strand Colors", 2D) = "white" {}
		_StrandColorStrength("Strand Color Multiply Strength", Range(0,1)) = 0.5

        [HideInInspector] _SrcBlend ("__src", Float) = 1.0
        [HideInInspector] _DstBlend ("__dst", Float) = 0.0
        [HideInInspector] _ZWrite ("__zw", Float) = 1.0
	}
	SubShader {
		Tags { "Queue"="AlphaTest" "RenderType"="TransparentCutout" }
		LOD 200
		Cull Back

        Blend [_SrcBlend] [_DstBlend]
        ZWrite [_ZWrite]
		
		CGPROGRAM
		#pragma surface surf Standard keepalpha
		//#pragma shader_feature _ _ALPHATEST_ON _ALPHABLEND_ON _ALPHAPREMULTIPLY_ON
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
		ENDCG




		CGPROGRAM
		#pragma surface surf Standard keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.05
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.10
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.15
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.20
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.25
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.30
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.35
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.40
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.45
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.50
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.55
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.60
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.65
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.70
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.75
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.80
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.85
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.90
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.95
		#include "FurPass.cginc"
		ENDCG


	}
	FallBack "Diffuse"
    CustomEditor "FurShaderGUI"
}
