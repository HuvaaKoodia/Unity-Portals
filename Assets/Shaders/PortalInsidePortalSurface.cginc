//Surface function used to draw a portal effect when seen inside the other portal

sampler2D _MainTex;
fixed4 _Color;
fixed4 _EmissionColor;
float _Speed;
sampler2D _ScrollNormal;
fixed4 _ScrollNormal_TexelSize;

struct Input {
	float2 uv_MainTex;
	float2 uv_ScrollNormal;
	float3 viewDir;
};

void surf(Input IN, inout SurfaceOutput o)
{
	// Albedo comes from a texture tinted by color
	float speedX = fmod(_Time * _Speed, _ScrollNormal_TexelSize.z);
	float speedY = fmod(_Time * _Speed, _ScrollNormal_TexelSize.w);
	fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;

	o.Albedo = c.rgb;
	o.Alpha = c.a;
	o.Emission = _EmissionColor;
	
	fixed4 n1 = tex2D(_ScrollNormal, float2(IN.uv_ScrollNormal.x + 1.2 + speedX, IN.uv_ScrollNormal.y - 1 + speedY));
	fixed4 n2 = tex2D(_ScrollNormal, float2(IN.uv_ScrollNormal.x - speedX, IN.uv_ScrollNormal.y - speedY));
	o.Normal = UnpackNormal((n1 * 0.5 + n2 * 0.5));
}