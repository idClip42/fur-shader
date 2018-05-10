using System;
using UnityEngine;

namespace UnityEditor
{
	internal class FurShaderGUI : ShaderGUI
	{

		private static class Styles
		{
			public static GUIContent fadeText = new GUIContent("Fade Rendering");
			public static GUIContent mainTexText = new GUIContent("Albedo/Alpha");
			public static GUIContent normalText = new GUIContent("Flow Map");
			public static GUIContent alphaStrText = new GUIContent("Alpha Strength");
			public static GUIContent noiseTexText = new GUIContent("Noise Alpha");
			public static GUIContent smoothText = new GUIContent("Smoothness");
			public static GUIContent metalText = new GUIContent("Metallic");
			public static GUIContent aoText = new GUIContent("AO Value");
			public static GUIContent aoColorText = new GUIContent("AO From Color");
			public static GUIContent lengthText = new GUIContent("Fur Length");
			public static GUIContent offsetText = new GUIContent("Fur Offset");
			public static GUIContent cutoffText = new GUIContent("Alpha Cutoff");
			public static GUIContent cutoffEndText = new GUIContent("Alpha Cutoff End");
			public static GUIContent edgeFadeText = new GUIContent("Edge Fade");
			public static GUIContent gravityText = new GUIContent("Gravity direction");
			public static GUIContent gravityStrText = new GUIContent("Gravity strength");
			public static GUIContent normInfText = new GUIContent("Normal Map Base Influence");
			public static GUIContent normInfTipText = new GUIContent("Normal Map Tip Influence");
			public static GUIContent strandText = new GUIContent("Strand Colors");
			public static GUIContent strandStrText = new GUIContent("Strand Color Multiply Strength");
			public static GUIContent windCloudText = new GUIContent("Cloud, Direction, Speed");

			public static GUIContent normInfEnableText = new GUIContent("Enable Normal Influence");
			public static GUIContent windEnableText = new GUIContent("Enable Wind");

			public static string primaryMapsText = "Main Maps";
			public static string noiseMapsText = "Noise Alpha";
			public static string furShapeText = "Fur Shape";
			public static string strandsText = "Strands";
			public static string windText = "Wind";
		}

		MaterialProperty fade = null;
		MaterialProperty color = null;
		MaterialProperty mainTex = null;
		MaterialProperty normal = null;
		MaterialProperty normalStr = null;
		MaterialProperty alphaStr = null;
		MaterialProperty noiseTex = null;
		MaterialProperty noiseStr = null;
		MaterialProperty smooth = null;
		MaterialProperty metal = null;
		MaterialProperty ao = null;
		MaterialProperty aoColor = null;
		MaterialProperty length = null;
		MaterialProperty offset = null;
		MaterialProperty cutoff = null;
		MaterialProperty cutoffEnd = null;
		MaterialProperty edgeFade = null;
		MaterialProperty gravity  = null;
		MaterialProperty gravityStr = null;
		MaterialProperty normInf = null;
		MaterialProperty strand = null;
		MaterialProperty strandStr = null;
		MaterialProperty windCloud = null;
		MaterialProperty windDir = null;

		MaterialProperty normInfEnable = null;
		MaterialProperty windEnable = null;
		MaterialProperty normInfTip = null;

		MaterialEditor m_MaterialEditor;


		public void FindProperties(MaterialProperty[] props)
		{
			fade = FindProperty("_Fade", props);
			color = FindProperty("_Color", props);
			mainTex = FindProperty("_MainTex", props);
			normal = FindProperty("_Normals", props);
			normalStr = FindProperty("_NormalStr", props);
			alphaStr = FindProperty("_AlphaMult", props);
			noiseTex = FindProperty("_NoiseTex", props);
			noiseStr = FindProperty("_NoiseMult", props);
			smooth = FindProperty("_Smoothness", props);
			metal = FindProperty("_Metallic", props);
			ao = FindProperty("_AO", props);
			aoColor = FindProperty("_AOColor", props);
			length = FindProperty("_FurLength", props);
			offset = FindProperty("_Offset", props);
			cutoff = FindProperty("_Cutoff", props);
			cutoffEnd = FindProperty("_CutoffEnd", props);
			edgeFade = FindProperty("_EdgeFade", props);
			gravity  = FindProperty("_Gravity", props);
			gravityStr = FindProperty("_GravityStrength", props);
			normInf = FindProperty("_NormInf", props);
			strand = FindProperty("_StrandTex", props);
			strandStr = FindProperty("_StrandColorStrength", props);
			windEnable = FindProperty("_Wind", props);
			windCloud = FindProperty("_WindCloud", props);
			windDir = FindProperty("_WindDir", props);
			normInfEnable = FindProperty("_NormInfEnable", props);
			normInfTip = FindProperty("_NormInfTip", props);
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
			EditorGUIUtility.labelWidth = 0f;

			//EditorGUI.BeginChangeCheck();
			//{

			// FADE RENDERING
			m_MaterialEditor.ShaderProperty(fade, Styles.fadeText);

			// PRIMARY MAPS
			GUILayout.Label(Styles.primaryMapsText, EditorStyles.boldLabel);
			m_MaterialEditor.TexturePropertySingleLine(Styles.mainTexText, mainTex, alphaStr, color);
			m_MaterialEditor.TexturePropertySingleLine(Styles.normalText, normal, normalStr);
//			m_MaterialEditor.TextureScaleOffsetProperty(mainTex);
//			m_MaterialEditor.ShaderProperty(alphaStr, Styles.alphaStrText);
//			m_MaterialEditor.ShaderProperty(noiseStr, Styles.noiseStrText);
			m_MaterialEditor.ShaderProperty(smooth, Styles.smoothText);
			m_MaterialEditor.ShaderProperty(metal, Styles.metalText);
			m_MaterialEditor.ShaderProperty(ao, Styles.aoText);
			m_MaterialEditor.ShaderProperty(aoColor, Styles.aoColorText);
//			EditorGUI.BeginChangeCheck();

			// NOISE ALPHA
//			GUILayout.Label(Styles.noiseMapsText, EditorStyles.boldLabel);
			m_MaterialEditor.TexturePropertySingleLine(Styles.noiseTexText, noiseTex, noiseStr);
			if(material.GetTexture("_NoiseTex") != null)
				m_MaterialEditor.TextureScaleOffsetProperty(noiseTex);

			EditorGUILayout.Space();
			// FUR SHAPE
			GUILayout.Label(Styles.furShapeText, EditorStyles.boldLabel);
			m_MaterialEditor.ShaderProperty(length, Styles.lengthText);
			m_MaterialEditor.ShaderProperty(offset, Styles.offsetText);
			m_MaterialEditor.ShaderProperty(cutoff, Styles.cutoffText);
			m_MaterialEditor.ShaderProperty(cutoffEnd, Styles.cutoffEndText);

			if(material.GetFloat("_Fade") == 1.0f)
				m_MaterialEditor.ShaderProperty(edgeFade, Styles.edgeFadeText);

			m_MaterialEditor.ShaderProperty(gravity, Styles.gravityText);
			m_MaterialEditor.ShaderProperty(gravityStr, Styles.gravityStrText);

			m_MaterialEditor.ShaderProperty(normInfEnable, Styles.normInfEnableText);
			if(material.GetFloat("_NormInfEnable") == 1.0f)
			{
				m_MaterialEditor.ShaderProperty(normInf, Styles.normInfText);
				m_MaterialEditor.ShaderProperty(normInfTip, Styles.normInfTipText);
			}
			
			EditorGUILayout.Space();

			// STRANDS
			GUILayout.Label(Styles.strandsText, EditorStyles.boldLabel);
			m_MaterialEditor.TexturePropertySingleLine(Styles.strandText, strand, strandStr);
//			m_MaterialEditor.ShaderProperty(strandStr, Styles.strandStrText);
			//}
			//if (EditorGUI.EndChangeCheck())
			//{
			//	//Debug.Log("Woo wee");
//				foreach(var obj in fade.targets)
//					SetupMaterialWithBlendMode((Material) obj, material.GetFloat("_Fade"));
				SetupMaterialWithBlendMode(material, material.GetFloat("_Fade"));
			//}
			EditorGUILayout.Space();

			// WIND
			GUILayout.Label(Styles.windText, EditorStyles.boldLabel);
			m_MaterialEditor.ShaderProperty(windEnable, Styles.windEnableText);
			if(material.GetFloat("_Wind") == 1.0f)
				m_MaterialEditor.TexturePropertySingleLine(Styles.windCloudText, windCloud, windDir);

		}

		public static void SetupMaterialWithBlendMode(Material material, float fade)
		{
			int fadeInt = Mathf.RoundToInt(fade);
			switch (fadeInt)
			{
			case 0:
				material.SetOverrideTag("RenderType", "TransparentCutout");
				material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
				material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.Zero);
				material.SetInt("_ZWrite", 1);
//				material.EnableKeyword("_ALPHATEST_ON");
//				material.DisableKeyword("_ALPHABLEND_ON");
//				material.DisableKeyword("_ALPHAPREMULTIPLY_ON");
				material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.AlphaTest;
				break;
			case 1:
				material.SetOverrideTag("RenderType", "Transparent");
				material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
				material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
				material.SetInt("_ZWrite", 0);
//				material.DisableKeyword("_ALPHATEST_ON");
//				material.EnableKeyword("_ALPHABLEND_ON");
//				material.DisableKeyword("_ALPHAPREMULTIPLY_ON");
				material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent;
				break;
			}
		}

	}

}