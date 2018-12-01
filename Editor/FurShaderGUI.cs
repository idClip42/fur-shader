using System;
using UnityEngine;

namespace UnityEditor
{
	internal class FurShaderGUI : ShaderGUI
	{

		private static class Styles
		{
			public static GUIContent tex = new GUIContent("Texture");
			public static GUIContent norm = new GUIContent("Normals");
			public static GUIContent noise = new GUIContent("Noise");
			public static GUIContent gradient = new GUIContent("Strand");

			public static GUIContent smooth = new GUIContent("Smoothness");
			public static GUIContent metal = new GUIContent("Metallic");
			public static GUIContent ao = new GUIContent("Occlusion");

			public static GUIContent enable2 = new GUIContent("Second Layer");
			public static GUIContent layer1 = new GUIContent("First Layer Length");
			public static GUIContent mask2 = new GUIContent("Second Layer Mask");

			public static GUIContent length = new GUIContent("Length");
			public static GUIContent curve = new GUIContent("Thickness Curve");
			public static GUIContent offset = new GUIContent("Offset");
			public static GUIContent cutoffBase = new GUIContent("Base Cutoff");
			public static GUIContent cutoffTip = new GUIContent("Tip Cutoff");
			public static GUIContent edgeFade = new GUIContent("Edge Fade");
			public static GUIContent gravDir = new GUIContent("Gravity Direction");
			public static GUIContent gravStr = new GUIContent("Gravity Strength");

			public static GUIContent normInfEnable = new GUIContent("Normal Influence");
			public static GUIContent normInf = new GUIContent("Base Influence");
			public static GUIContent normInfTip = new GUIContent("Tip Influence");

			public static GUIContent windEnable = new GUIContent("Wind");
			public static GUIContent wind = new GUIContent("Cloud, Direction, Speed");
		}

		MaterialProperty fade = null;

		MaterialProperty color = null;
		MaterialProperty mainTex = null;
		MaterialProperty normal = null;
		MaterialProperty normalStr = null;
		MaterialProperty noiseTex = null;
		MaterialProperty strand = null;
		MaterialProperty strandStr = null;

		MaterialProperty smooth = null;
		MaterialProperty metal = null;
		MaterialProperty ao = null;

		//MaterialProperty enable2 = null;
		//MaterialProperty layer1 = null;
		//MaterialProperty color2 = null;
		//MaterialProperty tex2 = null;
		//MaterialProperty mask2 = null;
		//MaterialProperty noise2 = null;
		//MaterialProperty strand2 = null;
		//MaterialProperty strandStr2 = null;

		MaterialProperty length = null;
		MaterialProperty thickCurve = null;
		MaterialProperty offset = null;
		MaterialProperty cutoff = null;
		MaterialProperty cutoffEnd = null;
		MaterialProperty edgeFade = null;

		MaterialProperty gravity  = null;
		MaterialProperty gravityStr = null;

		MaterialProperty normInfEnable = null;
		MaterialProperty normInf = null;
		MaterialProperty normInfTip = null;

		MaterialProperty windEnable = null;
		MaterialProperty windCloud = null;
		MaterialProperty windDir = null;

		MaterialEditor m_MaterialEditor;


		public void FindProperties(MaterialProperty[] props)
		{
			fade = FindProperty("_Fade", props);

			color = FindProperty("_Color", props);
			mainTex = FindProperty("_MainTex", props);
			normal = FindProperty("_Normals", props);
			normalStr = FindProperty("_NormalStr", props);
			noiseTex = FindProperty("_NoiseTex", props);
			strand = FindProperty("_StrandTex", props);
			strandStr = FindProperty("_StrandColorStrength", props);

			smooth = FindProperty("_Smoothness", props);
			metal = FindProperty("_Metallic", props);
			ao = FindProperty("_AO", props);

			//enable2 = FindProperty("_SecondLayer", props);
			//layer1 = FindProperty("_FirstLayer", props);
			//color2 = FindProperty("_SecondLayerColor", props);
			//tex2 = FindProperty("_SecondLayerTex", props);
			//mask2 = FindProperty("_SecondLayerMask", props);
			//noise2 = FindProperty("_SecondLayerNoise", props);
			//strand2 = FindProperty("_SecondLayerStrandTex", props);
			//strandStr2 = FindProperty("_SecondLayerStrandColorStrength", props);

			length = FindProperty("_FurLength", props);
			thickCurve = FindProperty("_ThicknessCurve", props);
			offset = FindProperty("_Offset", props);
			cutoff = FindProperty("_Cutoff", props);
			cutoffEnd = FindProperty("_CutoffEnd", props);
			edgeFade = FindProperty("_EdgeFade", props);

			gravity  = FindProperty("_Gravity", props);
			gravityStr = FindProperty("_GravityStrength", props);

			normInfEnable = FindProperty("_NormInfEnable", props);
			normInf = FindProperty("_NormInf", props);
			normInfTip = FindProperty("_NormInfTip", props);

			windEnable = FindProperty("_Wind", props);
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
			EditorGUIUtility.labelWidth = 0f;

			// FADE RENDERING
			m_MaterialEditor.ShaderProperty(fade, "Fade Rendering");

			// PRIMARY COLORS
			GUILayout.Label("Primary Textures", EditorStyles.boldLabel);
			m_MaterialEditor.TexturePropertySingleLine(Styles.tex, mainTex, color);
			m_MaterialEditor.TexturePropertySingleLine(Styles.norm, normal, normalStr);
			m_MaterialEditor.TexturePropertySingleLine(Styles.noise, noiseTex);
			m_MaterialEditor.TextureScaleOffsetProperty(noiseTex);
			m_MaterialEditor.TexturePropertySingleLine(Styles.gradient, strand, strandStr);

			//m_MaterialEditor.ShaderProperty(enable2, Styles.enable2);
			//if(material.GetFloat("_SecondLayer") == 1.0f)
			//{
			//	GUILayout.Label("Second Layer Textures", EditorStyles.boldLabel);
			//	m_MaterialEditor.ShaderProperty(layer1, Styles.layer1);
			//	m_MaterialEditor.TexturePropertySingleLine(Styles.tex, tex2, color2);
			//	m_MaterialEditor.TexturePropertySingleLine(Styles.mask2, mask2);
			//	m_MaterialEditor.TexturePropertySingleLine(Styles.noise, noise2);
			//	m_MaterialEditor.TextureScaleOffsetProperty(noise2);
			//m_MaterialEditor.TexturePropertySingleLine(Styles.gradient, strand2, strandStr2);
			//}

			// PROPERTIES
			GUILayout.Label("Material Properties", EditorStyles.boldLabel);
			m_MaterialEditor.ShaderProperty(smooth, Styles.smooth);
			m_MaterialEditor.ShaderProperty(metal, Styles.metal);
			m_MaterialEditor.ShaderProperty(ao, Styles.ao);

			// FUR SHAPE
			GUILayout.Label("Fur Shape", EditorStyles.boldLabel);
			m_MaterialEditor.ShaderProperty(length, Styles.length);
			m_MaterialEditor.ShaderProperty(thickCurve, Styles.curve);
			m_MaterialEditor.ShaderProperty(offset, Styles.offset);
			m_MaterialEditor.ShaderProperty(cutoff, Styles.cutoffBase);
			m_MaterialEditor.ShaderProperty(cutoffEnd, Styles.cutoffTip);
			if(material.GetFloat("_Fade") == 1.0f)
				m_MaterialEditor.ShaderProperty(edgeFade, Styles.edgeFade);
			m_MaterialEditor.ShaderProperty(gravity, Styles.gravDir);
			m_MaterialEditor.ShaderProperty(gravityStr, Styles.gravStr);

			// NORMAL INFLUENCE
			m_MaterialEditor.ShaderProperty(normInfEnable, Styles.normInfEnable);
			if(material.GetFloat("_NormInfEnable") == 1.0f)
			{
				m_MaterialEditor.ShaderProperty(normInf, Styles.normInf);
				m_MaterialEditor.ShaderProperty(normInfTip, Styles.normInfTip);
			}

			// WIND
			m_MaterialEditor.ShaderProperty(windEnable, Styles.windEnable);
			if(material.GetFloat("_Wind") == 1.0f)
				m_MaterialEditor.TexturePropertySingleLine(Styles.wind, windCloud, windDir);

			// BLEND MODE
			SetupMaterialWithBlendMode(material, material.GetFloat("_Fade"));	
		}



		

		public static void SetupMaterialWithBlendMode(Material material, float fade)
		{
			int fadeInt = Mathf.RoundToInt(fade);
			Debug.Log(fadeInt);
			switch (fadeInt)
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
				break;
			}
		}

	}

}