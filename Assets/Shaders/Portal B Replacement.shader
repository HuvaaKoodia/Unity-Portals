//Replacement subshaders for drawing objects inside the portals

Shader "Custom/Portal B Replacement Shader" {
	Properties{
		_Color("Main Color", Color) = (1,1,1,1)
		_MainTex("Base (RGB)", 2D) = "white" {}
		_BumpMap("Normalmap", 2D) = "bump" {}
	}

	SubShader
	{//This subshader marks portal A as a drawable area using the stencil buffer
		Tags{ "Queue" = "Geometry-10" "RenderType" = "PortalA" }

		Stencil
		{
			Ref 1
			Comp Always
			Pass Replace
			ZFail Replace
		}

		ColorMask 0
		ZWrite Off
		Cull off

		// Do nothing specific in the pass
		Pass{}
	}

	SubShader
	{//This subshader draws portal B inside the view from portal A
		Tags{ "Queue" = "Geometry+10" "RenderType" = "PortalB" }

		Blend SrcAlpha OneMinusSrcAlpha
		ZWrite On
		ZTest LEqual

		Stencil
		{//Only draw if inside the drawable portal area
		Ref 1
		Comp Equal
		}

		CGPROGRAM
		#pragma surface surf Lambert
		#include "PortalSurface.cginc"
		ENDCG
	}

	SubShader
	{//This subshader draws opaque geometry inside the portals.
		Tags{ "Queue" = "Geometry" "RenderType" = "Opaque"}
		Blend SrcAlpha OneMinusSrcAlpha
		LOD 200
		ZWrite On
		ZTest LEqual

		Stencil
		{//Only draw if inside the drawable portal area
			Ref 1
			Comp Equal
		}

		CGPROGRAM
		#pragma surface surf Lambert
		#include "WorldInsidePortalSurface.cginc"
		ENDCG
		}
	
	Fallback "Legacy Shaders/VertexLit"
}
