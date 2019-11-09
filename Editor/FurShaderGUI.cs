using System;
using UnityEngine;

namespace UnityEditor
{
	internal class FurShaderGUI : ShaderGUI
	{

		private static class Styles
		{
			public static GUIContent tex = new GUIContent("Color (RGB), Length(A), AO");
            public static GUIContent norm = new GUIContent("Normals");
            public static GUIContent gradient = new GUIContent("Strand Gradient");

            public static GUIContent noise = new GUIContent("Noise");
            public static GUIContent edgeFade = new GUIContent("Edge Fade");

            public static GUIContent heightMap = new GUIContent("Height Map");
            public static GUIContent offset = new GUIContent("Min Offset");

            public static GUIContent length = new GUIContent("Length");
            public static GUIContent lengthMin = new GUIContent("Length Min");

			public static GUIContent gravDir = new GUIContent("Gravity Direction (XYZ), Strength (W)");
            public static GUIContent tang = new GUIContent("Tangent Map");

			public static GUIContent wind = new GUIContent("Cloud Tex, Dir(XYZ), Speed(W)");
		}

		MaterialProperty color;
		MaterialProperty mainTex;
        MaterialProperty ao;

        MaterialProperty normal;
        MaterialProperty normalStr;

        MaterialProperty strand;
        MaterialProperty strandStr;

        MaterialProperty noiseTex;
        MaterialProperty noiseScale;
        MaterialProperty edgeFade;

        MaterialProperty length;
        MaterialProperty lengthMin;

        MaterialProperty heightMap;
        MaterialProperty tipOffset;
        MaterialProperty offset;

		MaterialProperty gravity;
        MaterialProperty tang;
        MaterialProperty normInf;

		MaterialProperty windCloud;
		MaterialProperty windDir;

		MaterialEditor m_MaterialEditor;


		public void FindProperties(MaterialProperty[] props)
		{
			color       = FindProperty("_Color", props);
			mainTex     = FindProperty("_MainTex", props);
            ao          = FindProperty("_AO", props);

            normal      = FindProperty("_Normals", props);
			normalStr   = FindProperty("_NormalStr", props);

            strand      = FindProperty("_StrandTex", props);
            strandStr   = FindProperty("_StrandTexStr", props);

            noiseTex    = FindProperty("_NoiseTex", props);
            noiseScale  = FindProperty("_NoiseScale", props);
            edgeFade    = FindProperty("_EdgeFade", props);

            length      = FindProperty("_FurLength", props);
            lengthMin   = FindProperty("_FurLengthMin", props);

            heightMap   = FindProperty("_HeightMap", props);
            tipOffset   = FindProperty("_TipOffset", props);
            offset      = FindProperty("_Offset", props);

			gravity     = FindProperty("_Gravity", props);
            tang        = FindProperty("_TangentMap", props);
            normInf     = FindProperty("_NormInf", props);

			windCloud   = FindProperty("_WindCloud", props);
			windDir     = FindProperty("_WindDir", props);
		}


		public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
		{
			FindProperties(props);
			m_MaterialEditor = materialEditor;
			ShaderPropertiesGUI(materialEditor.target as Material);
		}

        public void ShaderPropertiesGUI(Material material)
        {
            GUILayout.Label("Base", EditorStyles.boldLabel);
            m_MaterialEditor.TexturePropertySingleLine(Styles.tex, mainTex, color, ao);
            m_MaterialEditor.TexturePropertySingleLine(Styles.norm, normal, normalStr);
            m_MaterialEditor.TexturePropertySingleLine(Styles.gradient, strand, strandStr);

            GUILayout.Label("Thickness", EditorStyles.boldLabel);
            m_MaterialEditor.TexturePropertySingleLine(Styles.noise, noiseTex, noiseScale);
            m_MaterialEditor.ShaderProperty(edgeFade, Styles.edgeFade);

            GUILayout.Label("Length", EditorStyles.boldLabel);
            m_MaterialEditor.ShaderProperty(length, Styles.length);
            m_MaterialEditor.ShaderProperty(lengthMin, Styles.lengthMin);

            GUILayout.Label("Offset", EditorStyles.boldLabel);
            m_MaterialEditor.TexturePropertySingleLine(Styles.heightMap, heightMap, tipOffset);
            m_MaterialEditor.ShaderProperty(offset, Styles.offset);

            GUILayout.Label("Flow", EditorStyles.boldLabel);
            m_MaterialEditor.ShaderProperty(gravity, Styles.gravDir);
            m_MaterialEditor.TexturePropertySingleLine(Styles.tang, tang, normInf);

            GUILayout.Label("Wind", EditorStyles.boldLabel);
            m_MaterialEditor.TexturePropertySingleLine(Styles.wind, windCloud, windDir);

            SetupMaterialWithBlendMode(material, (material.GetFloat("_EdgeFade") > 0.01f) ? 1 : 0);
        }



		

		public static void SetupMaterialWithBlendMode(Material material, float fade)
		{
			switch (Mathf.RoundToInt(fade))
			{
			case 0:
				material.SetOverrideTag("RenderType", "TransparentCutout");
				material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
				material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.Zero);
				material.SetInt("_ZWrite", 1);
				material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.AlphaTest;
                material.DisableKeyword("_FADE_ON");
				break;
			case 1:
				material.SetOverrideTag("RenderType", "Transparent");
				material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
				material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
				material.SetInt("_ZWrite", 0);
				material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent;
                material.EnableKeyword("_FADE_ON");
                break;
			}
		}

	}

}