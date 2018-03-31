using System;
using UnityEngine;

namespace UnityEditor
{
	internal class FurShaderGUI : ShaderGUI
	{

		private static class Styles
		{
			public static GUIContent fadeText = new GUIContent("Fade Rendering");
			public static GUIContent colorText = new GUIContent("Color");
			public static GUIContent mainTexText = new GUIContent("Albedo");
			public static GUIContent alphaStrText = new GUIContent("Alpha Strength");
			public static GUIContent noiseTexText = new GUIContent("Noise");
			public static GUIContent noiseStrText = new GUIContent("Noise Strength");
			public static GUIContent smoothText = new GUIContent("Smoothness");
			public static GUIContent metalText = new GUIContent("Metallic");
			public static GUIContent aoText = new GUIContent("Ambient Occlusion Strength");
			public static GUIContent aoColorText = new GUIContent("Ambient Occlusion From Color");
			public static GUIContent lengthText = new GUIContent("Fur Length");
			public static GUIContent cutoffText = new GUIContent("Alpha Cutoff");
			public static GUIContent cutoffEndText = new GUIContent("Alpha Cutoff End");
			public static GUIContent edgeFadeText = new GUIContent("Edge Fade");
			public static GUIContent gravityText = new GUIContent("Gravity direction");
			public static GUIContent gravityStrText = new GUIContent("Gravity strength");
			public static GUIContent strandText = new GUIContent("Strand Colors");
			public static GUIContent strandStrText = new GUIContent("Strand Color Multiply Strength");

			public static string primaryMapsText = "Main Maps";
			public static string furShapeText = "Fur Shape";
			public static string strandsText = "Strands";
		}

		MaterialProperty fade = null;
		MaterialProperty color = null;
		MaterialProperty mainTex = null;
		MaterialProperty alphaStr = null;
		MaterialProperty noiseTex = null;
		MaterialProperty noiseStr = null;
		MaterialProperty smooth = null;
		MaterialProperty metal = null;
		MaterialProperty ao = null;
		MaterialProperty aoColor = null;
		MaterialProperty length = null;
		MaterialProperty cutoff = null;
		MaterialProperty cutoffEnd = null;
		MaterialProperty edgeFade = null;
		MaterialProperty gravity  = null;
		MaterialProperty gravityStr = null;
		MaterialProperty strand = null;
		MaterialProperty strandStr  = null;

		MaterialEditor m_MaterialEditor;


		public void FindProperties(MaterialProperty[] props)
		{
			fade = FindProperty("_Fade", props);
			color = FindProperty("_Color", props);
			mainTex = FindProperty("_MainTex", props);
			alphaStr = FindProperty("_AlphaMult", props);
			noiseTex = FindProperty("_NoiseTex", props);
			noiseStr = FindProperty("_NoiseMult", props);
			smooth = FindProperty("_Smoothness", props);
			metal = FindProperty("_Metallic", props);
			ao = FindProperty("_AO", props);
			aoColor = FindProperty("_AOColor", props);
			length = FindProperty("_FurLength", props);
			cutoff = FindProperty("_Cutoff", props);
			cutoffEnd = FindProperty("_CutoffEnd", props);
			edgeFade = FindProperty("_EdgeFade", props);
			gravity  = FindProperty("_Gravity", props);
			gravityStr = FindProperty("_GravityStrength", props);
			strand = FindProperty("_StrandTex", props);
			strandStr = FindProperty("_StrandColorStrength", props);
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
			m_MaterialEditor.ShaderProperty(fade, Styles.fadeText);

			GUILayout.Label(Styles.primaryMapsText, EditorStyles.boldLabel);
			m_MaterialEditor.TexturePropertySingleLine(Styles.mainTexText, mainTex, color);
			m_MaterialEditor.TextureScaleOffsetProperty(mainTex);
			m_MaterialEditor.ShaderProperty(alphaStr, Styles.alphaStrText);
			m_MaterialEditor.TexturePropertySingleLine(Styles.noiseTexText, noiseTex);
			m_MaterialEditor.TextureScaleOffsetProperty(noiseTex);
			m_MaterialEditor.ShaderProperty(noiseStr, Styles.noiseStrText);
			m_MaterialEditor.ShaderProperty(smooth, Styles.smoothText);
			m_MaterialEditor.ShaderProperty(metal, Styles.metalText);
			m_MaterialEditor.ShaderProperty(ao, Styles.aoText);
			m_MaterialEditor.ShaderProperty(aoColor, Styles.aoColorText);
			EditorGUI.BeginChangeCheck();
			EditorGUILayout.Space();

			GUILayout.Label(Styles.furShapeText, EditorStyles.boldLabel);
			m_MaterialEditor.ShaderProperty(length, Styles.lengthText);
			m_MaterialEditor.ShaderProperty(cutoff, Styles.cutoffText);
			m_MaterialEditor.ShaderProperty(cutoffEnd, Styles.cutoffEndText);

			if(material.GetFloat("_Fade") == 1.0f)
				m_MaterialEditor.ShaderProperty(edgeFade, Styles.edgeFadeText);

			m_MaterialEditor.ShaderProperty(gravity, Styles.gravityText);
			m_MaterialEditor.ShaderProperty(gravityStr, Styles.gravityStrText);
			EditorGUILayout.Space();

			GUILayout.Label(Styles.strandsText, EditorStyles.boldLabel);
			m_MaterialEditor.TexturePropertySingleLine(Styles.strandText, strand);
			m_MaterialEditor.ShaderProperty(strandStr, Styles.strandStrText);
			//}
			//if (EditorGUI.EndChangeCheck())
			//{
			//	//Debug.Log("Woo wee");
//				foreach(var obj in fade.targets)
//					SetupMaterialWithBlendMode((Material) obj, material.GetFloat("_Fade"));
				SetupMaterialWithBlendMode(material, material.GetFloat("_Fade"));
			//}

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
				material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.SrcAlpha);
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