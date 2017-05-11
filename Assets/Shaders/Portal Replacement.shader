//Replacement subshaders for drawing objects inside the portals

Shader "Custom/Portal Replacement Shader" {
	Properties{
		_Color("Main Color", Color) = (1,1,1,1)
		_MainTex("Base (RGB)", 2D) = "white" {}
	}

	SubShader
	{//This subshader marks the portals as drawable areas using the stencil buffer
		Tags{ "Queue" = "Geometry-10" "RenderType" = "Portal" }

		Stencil{
			Ref 1
			Comp Always
			Pass Replace
			ZFail Replace
		}

		Cull off
		ZWrite Off
		ColorMask 0

		// Do nothing specific in the pass
		Pass{}
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

		sampler2D _MainTex;
		fixed4 _Color;

		struct Input {
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
		}
	
	Fallback "Legacy Shaders/VertexLit"
}
