Shader "Fur/Fur (05 Shells)" {
	Properties {

		[Toggle] _Fade ("Fade Render", Float) = 0.0
        
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo", 2D) = "white" {}
		_Normals ("Normal Map", 2D) = "bump" {}
		_NormalStr ("Normal Strength", Range(0,1)) = 1
		_NoiseTex ("Noise", 2D) = "white" {}
		_StrandTex ("Strand Gradient", 2D) = "white" {}
		_StrandColorStrength("Strand Color Multiply Strength", Range(0,1)) = 0.5
		_AO("Ambient Occlusion Strength", Range(0,1)) = 0.5
        _Metallic("Metallic", Range(0,1)) = 0

		_FurLength ("Fur Length", Range (.0002, 0.25)) = 0.1
        _FurLengthMin ("Fur Length Minimum", Range (.0002, 0.25)) = 0.0
		_ThicknessCurve ("Thickness Curve", Range(0,1)) = 0.75
		_Offset ("Fur Offset", Range(-0.25, 0.25)) = 0
		_Cutoff ("Alpha cutoff base", Range(0,1)) = 0
		_CutoffEnd ("Alpha cutoff tip", Range(0,1)) = 0.5
		_EdgeFade ("Edge fade", Range(0,0.5)) = 0.5
        
		_Gravity ("Gravity direction", Vector) = (0,-1,0,0.3)
        
		_NormInf ("Normal Influence", Range(0,1)) = 0
		_NormInfTip ("Normal Influence On Tip", Range(0,1)) = 0
        
		_WindCloud ("Wind Cloud", 2D) = "black" {}
		_WindDir ("Wind Direction and Speed", Vector) = (0,0,0,0)

        [HideInInspector] _SrcBlend ("__src", Float) = 1.0
        [HideInInspector] _DstBlend ("__dst", Float) = 0.0
        [HideInInspector] _ZWrite ("__zw", Float) = 1.0
	}
	SubShader {
		Tags { "Queue"="AlphaTest" "RenderType"="TransparentCutout" }
		LOD 200


		Cull Off
        Blend One Zero
        ZWrite On


		CGPROGRAM
		#pragma surface surf Standard vertex:vert
		#include "FurBasePass.cginc"
		ENDCG


		Cull Back
        Blend [_SrcBlend] [_DstBlend]
        ZWrite [_ZWrite]
        
        
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.20
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc"
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.40
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.60
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 0.80
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature _FADE_ON
		#define FUR_MULTIPLIER 1.00
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG


	}
	FallBack "Diffuse"
    CustomEditor "FurShaderGUI"
}
