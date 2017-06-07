//Surface function used to draw the portal border and the portal effect when seen inside the other portal

sampler2D _MainTex;
fixed4 _MainTex_TexelSize;
sampler2D _MaskTex;
float _Speed;
fixed4 _Color;
fixed4 _Emission;

struct Input {
	float2 uv_MainTex;
	float2 uv_MaskTex;
};

void surf(Input IN, inout SurfaceOutput o) {
	float speedX = fmod(_Time * _Speed, _MainTex_TexelSize.z);
	float speedY = fmod(_Time * _Speed, _MainTex_TexelSize.w);
	fixed4 c1 = tex2D(_MainTex, float2(IN.uv_MainTex.x + 1.2 + speedX, IN.uv_MainTex.y - 1 + speedY));
	fixed4 c2 = tex2D(_MainTex, float2(IN.uv_MainTex.x - speedX, IN.uv_MainTex.y - speedY));

	fixed4 c = (c1 * 0.5 + c2 * 0.5) * _Color;
	o.Albedo = c.rgb;
	o.Alpha = tex2D(_MaskTex, IN.uv_MaskTex).a;
	o.Emission = _Emission;
}
