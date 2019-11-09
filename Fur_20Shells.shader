Shader "Fur/Fur (20 Shells)" {

    Properties {
        _Color          ("", Color)                 = (1, 1, 1, 1)
        _MainTex        ("", 2D)                    = "white" {}
        _AO             ("", Range (0,1))           = 0.5
        
        _Normals        ("", 2D)                    = "bump" {}
        _NormalStr      ("", Range (0,1))           = 1
        
        _StrandTex      ("", 2D)                    = "white" {}
        _StrandTexStr   ("", Range (0,1))           = 0.5
        
        _NoiseTex       ("", 2D)                    = "white" {}
        _NoiseScale     ("", Range (0.1, 30))       = 10
        _EdgeFade       ("", Range (0,0.5))         = 0.5
        
        _FurLength      ("", Range (.0002, 0.25))   = 0.1
        _FurLengthMin   ("", Range (.0002, 0.25))   = 0.0
        
        _HeightMap      ("", 2D)                    = "black" {}
        _Offset         ("", Range (-0.25, 0.25))   = 0
        _TipOffset      ("", Range (0, 0.25))       = 0
        
        _Gravity        ("", Vector)                = (0, -1, 0, 0.3)
        _TangentMap     ("", 2D)                    = "bump" {}
        _NormInf        ("", Range (0,1))           = 0
        
        _WindCloud      ("", 2D)                    = "black" {}
        _WindDir        ("", Vector)                = (0, 0, 0, 0)

        [HideInInspector] _SrcBlend ("", Float)     = 1.0
        [HideInInspector] _DstBlend ("", Float)     = 0.0
        [HideInInspector] _ZWrite   ("", Float)     = 1.0
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
		#pragma surface surf Standard keepalpha vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.05
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.10
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.15
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.20
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.25
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.30
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.35
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.40
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.45
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.50
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.55
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.60
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.65
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.70
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.75
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.80
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.85
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.90
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha  vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 0.95
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG
		CGPROGRAM
		#pragma surface surf Standard  keepalpha vertex:vert
		#pragma shader_feature_local _FADE_ON
		#define FUR_MULTIPLIER 1.00
        #define SURF_OUTPUT SurfaceOutputStandard
		#include "FurPassProps.cginc" 
        #include "FurPassVert.cginc" 
        #include "FurPass.cginc"
		ENDCG


	}
	FallBack "Diffuse"
    CustomEditor "FurShaderGUI"
}
