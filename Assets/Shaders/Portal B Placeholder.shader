Shader "Custom/Portal B Placeholder" {
	
	Properties{
		_Color("Main Color", Color) = (1,1,1,1)
		_MainTex("Base (RGB)", 2D) = "white" {}

		_ScrollNormal("Scrolling Normal", 2D) = "white" {}
		_EmissionColor("Emission Color", Color) = (1,1,1,1)
		_Speed("Speed", float) = 10
	}

	SubShader
	{
		Tags{ "Queue" = "Geometry-10" "RenderType" = "PortalB" }

		ColorMask 0
		ZWrite On

		Pass{}
	}
}
