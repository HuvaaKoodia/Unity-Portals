Shader "Custom/Portal B Placeholder" {
	
	Properties{
		_Color("Main Color", Color) = (1,1,1,1)
		_Emission("Emission Color", Color) = (0,0,0,1)
		_MainTex("Diffuse", 2D) = "white" {}
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
