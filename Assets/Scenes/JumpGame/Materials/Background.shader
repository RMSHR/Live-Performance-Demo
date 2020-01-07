// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Background"
{
	Properties
	{
		_TessPhongStrength( "Phong Tess Strength", Range( 0, 1 ) ) = 0.5
		_GridSize("GridSize", Float) = 10
		_LineSize("LineSize", Float) = 0.1
		_Speed("Speed", Float) = 0.1
		_GridColor("GridColor", Color) = (1,1,1,0)
		_Glow("Glow", Float) = 1
		_WaveLength("WaveLength", Float) = 3
		_WaveHeight("WaveHeight", Float) = 10
		_GlowImpulse("GlowImpulse", Float) = 1
		_GloImpulseSpeed("GloImpulseSpeed", Float) = 2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction tessphong:_TessPhongStrength 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Speed;
		uniform float _WaveLength;
		uniform float _WaveHeight;
		uniform float4 _GridColor;
		uniform float _GlowImpulse;
		uniform float _GloImpulseSpeed;
		uniform float _Glow;
		uniform float _GridSize;
		uniform float _LineSize;
		uniform float _TessPhongStrength;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			float4 appendResult25 = (float4(10.0 , 10.0 , 10.0 , 10.0));
			return appendResult25;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float mulTime12 = _Time.y * _Speed;
			float2 appendResult32 = (float2(( v.texcoord.xy.y + mulTime12 ) , v.texcoord.xy.x));
			float simplePerlin2D29 = snoise( appendResult32*_WaveLength );
			simplePerlin2D29 = simplePerlin2D29*0.5 + 0.5;
			float4 appendResult18 = (float4(0.0 , ( simplePerlin2D29 * _WaveHeight ) , 0.0 , 0.0));
			v.vertex.xyz += appendResult18.xyz;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float mulTime35 = _Time.y * _GloImpulseSpeed;
			float mulTime12 = _Time.y * _Speed;
			o.Emission = ( _GridColor * ( 1.0 + ( _GlowImpulse * frac( mulTime35 ) * _Glow ) ) * ( step( frac( ( ( i.uv_texcoord.x + 0.0 ) * _GridSize ) ) , _LineSize ) + step( frac( ( ( i.uv_texcoord.y + mulTime12 ) * _GridSize ) ) , _LineSize ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
-99.2;440.8;1178;819;1428.664;495.0292;1.883002;True;False
Node;AmplifyShaderEditor.RangedFloatNode;14;-1388.894,223.953;Inherit;False;Property;_Speed;Speed;2;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1574.833,-11.96059;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;12;-1205.594,191.4531;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;11;-1000.193,-56.84697;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-810.5182,13.16679;Inherit;False;Property;_GridSize;GridSize;0;0;Create;True;0;0;False;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-779.2457,-296.2847;Inherit;False;Property;_GloImpulseSpeed;GloImpulseSpeed;8;0;Create;True;0;0;False;0;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-983.2937,74.45307;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-1259.402,996.4207;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-704.2617,842.9568;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-635.3424,-70.02119;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-647.803,92.01511;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;35;-524.7755,-284.666;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-113.8361,-179.6299;Inherit;False;Property;_Glow;Glow;4;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-285.8994,-375.3707;Inherit;False;Property;_GlowImpulse;GlowImpulse;7;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;36;-299.0804,-286.8695;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;32;-442.3642,917.9072;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FractNode;5;-383.1186,-72.50659;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-693.1745,1103.084;Inherit;False;Property;_WaveLength;WaveLength;5;0;Create;True;0;0;False;0;3;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;6;-354.1792,145.1174;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-361.7913,33.9903;Inherit;False;Property;_LineSize;LineSize;1;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;66.22195,-292.5187;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-159.9662,1140.281;Inherit;False;Property;_WaveHeight;WaveHeight;6;0;Create;True;0;0;False;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;7;-180.5428,-63.24597;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;29;-243.2377,899.1487;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;9;-176.1339,107.7539;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;61.40441,1011.148;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;296.1661,-254.0049;Inherit;False;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;10;-17.39404,45.85309;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;15;254.373,-470.2728;Inherit;False;Property;_GridColor;GridColor;3;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;24;461.961,644.2656;Inherit;False;Constant;_Tesselation;Tesselation;6;0;Create;True;0;0;False;0;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;511.7791,-309.0516;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;623.3534,660.6092;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;18;364.8059,426.7531;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;840.6169,175.4518;Float;False;True;-1;6;ASEMaterialInspector;0;0;Unlit;Background;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;True;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;14;0
WireConnection;11;0;1;1
WireConnection;13;0;1;2
WireConnection;13;1;12;0
WireConnection;30;0;19;2
WireConnection;30;1;12;0
WireConnection;2;0;11;0
WireConnection;2;1;3;0
WireConnection;4;0;13;0
WireConnection;4;1;3;0
WireConnection;35;0;38;0
WireConnection;36;0;35;0
WireConnection;32;0;30;0
WireConnection;32;1;19;1
WireConnection;5;0;2;0
WireConnection;6;0;4;0
WireConnection;39;0;40;0
WireConnection;39;1;36;0
WireConnection;39;2;17;0
WireConnection;7;0;5;0
WireConnection;7;1;8;0
WireConnection;29;0;32;0
WireConnection;29;1;22;0
WireConnection;9;0;6;0
WireConnection;9;1;8;0
WireConnection;33;0;29;0
WireConnection;33;1;34;0
WireConnection;41;1;39;0
WireConnection;10;0;7;0
WireConnection;10;1;9;0
WireConnection;16;0;15;0
WireConnection;16;1;41;0
WireConnection;16;2;10;0
WireConnection;25;0;24;0
WireConnection;25;1;24;0
WireConnection;25;2;24;0
WireConnection;25;3;24;0
WireConnection;18;1;33;0
WireConnection;0;2;16;0
WireConnection;0;11;18;0
WireConnection;0;14;25;0
ASEEND*/
//CHKSM=4518281273617565AFE4D8930D87C98C6FAEB8BB