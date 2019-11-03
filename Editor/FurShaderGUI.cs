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
            public static GUIContent tang = new GUIContent("Tangent Map");
            public static GUIContent noise = new GUIContent("Noise");
            public static GUIContent noiseScale = new GUIContent("NoiseScale");
            public static GUIContent gradient = new GUIContent("Strand Gradient");
            public static GUIContent metallic = new GUIContent("Metallic");
            public static GUIContent heightMap = new GUIContent("Height Map");

            public static GUIContent length = new GUIContent("Length");
            public static GUIContent lengthMin = new GUIContent("Length Min");
            public static GUIContent curve = new GUIContent("Thickness Curve");
            public static GUIContent offset = new GUIContent("Min Offset");
            public static GUIContent tipOffset = new GUIContent("Max Offset");
            public static GUIContent cutoffBase = new GUIContent("Base Thin");
			public static GUIContent cutoffTip = new GUIContent("Tip Thin");
			public static GUIContent edgeFade = new GUIContent("Edge Fade");
			public static GUIContent gravDir = new GUIContent("Gravity Direction (XYZ), Strength (W)");

            public static GUIContent normXFlip = new GUIContent("Flip Normal X");
            public static GUIContent normYFlip = new GUIContent("Flip Normal Y");
            public static GUIContent normZFlip = new GUIContent("Flip Normal Z");

            public static GUIContent normInf = new GUIContent("Tangent Map Base Influence");
			public static GUIContent normInfTip = new GUIContent("Tangent Map Tip Influence");

			public static GUIContent wind = new GUIContent("Wind Cloud, Dir(XYZ), Speed(W)");
		}

		//MaterialProperty fade = null;

		MaterialProperty color = null;
		MaterialProperty mainTex = null;
        MaterialProperty normal = null;
        MaterialProperty normalStr = null;
        MaterialProperty tang = null;
        MaterialProperty noiseTex = null;
        MaterialProperty noiseScale = null;
        MaterialProperty strand = null;
		MaterialProperty strandStr = null;
        MaterialProperty ao = null;
        MaterialProperty metal = null;
        MaterialProperty heightMap = null;

        MaterialProperty length = null;
        MaterialProperty lengthMin = null;
        MaterialProperty thickCurve = null;
        MaterialProperty offset = null;
        MaterialProperty tipOffset = null;
        MaterialProperty cutoff = null;
		MaterialProperty cutoffEnd = null;
		MaterialProperty edgeFade = null;

		MaterialProperty gravity  = null;

        MaterialProperty normXFlip = null;
        MaterialProperty normYFlip = null;
        MaterialProperty normZFlip = null;
        MaterialProperty normInf = null;
        MaterialProperty normInfTip = null;

		MaterialProperty windCloud = null;
		MaterialProperty windDir = null;

		MaterialEditor m_MaterialEditor;


		public void FindProperties(MaterialProperty[] props)
		{
			//fade = FindProperty("_Fade", props);

			color = FindProperty("_Color", props);
			mainTex = FindProperty("_MainTex", props);
			normal = FindProperty("_Normals", props);
			normalStr = FindProperty("_NormalStr", props);
            tang = FindProperty("_TangentMap", props);
            noiseTex = FindProperty("_NoiseTex", props);
            noiseScale = FindProperty("_NoiseScale", props);
            strand = FindProperty("_StrandTex", props);
			strandStr = FindProperty("_StrandColorStrength", props);
            ao = FindProperty("_AO", props);
            metal = FindProperty("_Metallic", props);
            heightMap = FindProperty("_HeightMap", props);

            length = FindProperty("_FurLength", props);
            lengthMin = FindProperty("_FurLengthMin", props);
            thickCurve = FindProperty("_ThicknessCurve", props);
            offset = FindProperty("_Offset", props);
            tipOffset = FindProperty("_TipOffset", props);
            cutoff = FindProperty("_Cutoff", props);
			cutoffEnd = FindProperty("_CutoffEnd", props);
			edgeFade = FindProperty("_EdgeFade", props);

			gravity  = FindProperty("_Gravity", props);

            normXFlip = FindProperty("_NormXFlip", props);
            normYFlip = FindProperty("_NormYFlip", props);
            normZFlip = FindProperty("_NormZFlip", props);

            normInf = FindProperty("_NormInf", props);
			normInfTip = FindProperty("_NormInfTip", props);

			windCloud = FindProperty("_WindCloud", props);
			windDir = FindProperty("_WindDir", props);
		}


		public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
		{
			FindProperties(props);
			m_MaterialEditor = materialEditor;
			Material material = materialEditor.target as Material;

			ShaderPropertiesGUI(material);
		}

        public void ShaderPropertiesGUI(Material material)
        {
            GUILayout.Label("Base", EditorStyles.boldLabel);
            m_MaterialEditor.TexturePropertySingleLine(Styles.tex, mainTex, color, ao);
            m_MaterialEditor.TexturePropertySingleLine(Styles.norm, normal, normalStr);
            m_MaterialEditor.TexturePropertySingleLine(Styles.gradient, strand, strandStr);
            //m_MaterialEditor.ShaderProperty(metal, Styles.metallic);

            GUILayout.Label("Thickness", EditorStyles.boldLabel);
            m_MaterialEditor.TexturePropertySingleLine(Styles.noise, noiseTex, noiseScale);
            m_MaterialEditor.ShaderProperty(cutoff, Styles.cutoffBase);
            m_MaterialEditor.ShaderProperty(cutoffEnd, Styles.cutoffTip);
            //m_MaterialEditor.ShaderProperty(thickCurve, Styles.curve);
            m_MaterialEditor.ShaderProperty(edgeFade, Styles.edgeFade);

            GUILayout.Label("Length", EditorStyles.boldLabel);
            m_MaterialEditor.ShaderProperty(length, Styles.length);
            m_MaterialEditor.ShaderProperty(lengthMin, Styles.lengthMin);

            GUILayout.Label("Offset", EditorStyles.boldLabel);
            m_MaterialEditor.TexturePropertySingleLine(Styles.heightMap, heightMap, tipOffset);
            m_MaterialEditor.ShaderProperty(offset, Styles.offset);

            GUILayout.Label("Flow", EditorStyles.boldLabel);
            m_MaterialEditor.ShaderProperty(gravity, Styles.gravDir);
            m_MaterialEditor.TexturePropertySingleLine(Styles.tang, tang);
            m_MaterialEditor.ShaderProperty(normInf, Styles.normInf);
            m_MaterialEditor.ShaderProperty(normInfTip, Styles.normInfTip);
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
				// material.EnableKeyword("_ALPHATEST_ON");
				// material.DisableKeyword("_ALPHABLEND_ON");
				// material.DisableKeyword("_ALPHAPREMULTIPLY_ON");
				material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.AlphaTest;
                material.DisableKeyword("_FADE_ON");
				break;
			case 1:
				material.SetOverrideTag("RenderType", "Transparent");
				material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
				material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
				material.SetInt("_ZWrite", 0);
				// material.DisableKeyword("_ALPHATEST_ON");
				// material.EnableKeyword("_ALPHABLEND_ON");
				// material.DisableKeyword("_ALPHAPREMULTIPLY_ON");
				material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent;
                material.EnableKeyword("_FADE_ON");
                break;
			}
		}

	}

}