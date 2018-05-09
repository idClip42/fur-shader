Shader "Fur/Fur" {
	Properties {
        [Toggle] _Fade ("Fade Render", Float) = 0.0
        [Toggle] _NormInfEnable("Normal Influence on Vertices", Float) = 0.0
        [Toggle] _Wind("Wind", Float) = 0.0

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

		_FurLength ("Fur Length", Range (.0002, 0.25)) = 0.1
		_Offset ("Fur Offset", Range(-0.25, 0.25)) = 0
		_Cutoff ("Alpha cutoff", Range(0,1)) = 0
		_CutoffEnd ("Alpha cutoff end", Range(0,1)) = 0.5
		_EdgeFade ("Edge fade", Range(0,1)) = 0.5

		_Gravity ("Gravity direction", Vector) = (0,0,1,0)
		_GravityStrength ("Gravity strength", Range(0,1)) = 0.25

		_NormInf ("Normal Influence", Range(0,1)) = 0
		_NormInfTip ("Normal Influence On Tip", Range(0,1)) = 0

		_StrandTex ("Strand Colors", 2D) = "white" {}
		_StrandColorStrength("Strand Color Multiply Strength", Range(0,1)) = 0.5

		_WindCloud ("Wind Cloud", 2D) = "black" {}
		_WindDir ("Wind Direction and Speed", Vector) = (0,0,0,0)

        [HideInInspector] _SrcBlend ("__src", Float) = 1.0
        [HideInInspector] _DstBlend ("__dst", Float) = 0.0
        [HideInInspector] _ZWrite ("__zw", Float) = 1.0
	}
	SubShader {
		Tags { "Queue"="AlphaTest" "RenderType"="TransparentCutout" }
		LOD 200
		Cull Back


        Blend One Zero
        ZWrite On


		CGPROGRAM
		#pragma surface surf Standard vertex:vert
		#include "FurBasePass.cginc"
		ENDCG


        Blend [_SrcBlend] [_DstBlend]
        ZWrite [_ZWrite]


		CGPROGRAM
		#pragma surface surf Standard keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.05
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.10
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.15
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.20
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.25
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.30
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.35
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.40
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.45
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.50
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.55
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.60
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.65
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.70
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.75
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.80
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.85
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.90
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 0.95
		#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		// #pragma shader_feature _NORMINFENABLE_ON
		#pragma shader_feature _WIND_ON
		#define FUR_MULTIPLIER 1.00
		#include "FurPass.cginc"
		ENDCG


	}
	FallBack "Diffuse"
    CustomEditor "FurShaderGUI"
}
