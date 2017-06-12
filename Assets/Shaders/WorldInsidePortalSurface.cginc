//Surface function used to draw the world inside the portals.

sampler2D _MainTex;
sampler2D _BumpMap;
fixed4 _Color;
half _Shininess;

struct Input {
	float2 uv_MainTex;
	float2 uv_BumpMap;
};

void surf(Input IN, inout SurfaceOutput o) {
	fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
	o.Albedo = c.rgb * _Color.rgb;
	o.Alpha = c.a * _Color.a;
	o.Gloss = c.a;
	o.Specular = _Shininess;
	o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
}