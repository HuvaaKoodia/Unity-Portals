//Replacement subshaders for drawing objects inside the A portal

Shader "Custom/Portal A Replacement Shader" {
	SubShader
	{//This subshader marks portal B as a drawable area using the stencil buffer
		Tags{ "Queue" = "Geometry-10" "RenderType" = "PortalB" }

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

		Pass{}
	}

	SubShader
	{//This subshader draws the portal A effect inside the view from portal B
		Tags{ "Queue" = "Geometry+10" "RenderType" = "PortalA" }

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
		#pragma surface surf BlinnPhong
		#include "WorldInsidePortalSurface.cginc"
		ENDCG
		}
	
	Fallback "Legacy Shaders/VertexLit"
}
