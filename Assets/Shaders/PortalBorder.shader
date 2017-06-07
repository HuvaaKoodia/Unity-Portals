// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

Shader "Custom\PortalBorder" {
	Properties{
		_Color("Main Color", Color) = (1,1,1,1)
		_Emission("Emission Color", Color) = (0,0,0,1)
		_MainTex("Diffuse", 2D) = "white" {}
		_MaskTex("Mask", 2D) = "white" {}
		_Speed("Speed", float) = 1
	}

		SubShader{
		Tags{ "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
		LOD 200

		CGPROGRAM
#pragma surface surf Lambert alpha:fade
#include "PortalSurface.cginc"
			ENDCG
	}

	Fallback "Legacy Shaders/Transparent/VertexLit"
}
