// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "enviro"
{
	Properties
	{
		_lineColor("lineColor", Color) = (0,0.9226117,1,0)
		_backgroundColor("backgroundColor", Color) = (0.02865789,0.1411895,0.2641509,0)
		_LineNumber("LineNumber", Float) = 5
		_Speed("Speed", Float) = 1
		_GlowPower("GlowPower", Float) = 3
		_LineSize("LineSize", Float) = 0
		_HueShift("HueShift", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _HueShift;
		uniform float4 _backgroundColor;
		uniform float4 _lineColor;
		uniform float _GlowPower;
		uniform float _Speed;
		uniform float _LineNumber;
		uniform float _LineSize;


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		float3 RGBToHSV(float3 c)
		{
			float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
			float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
			float d = q.x - min( q.w, q.y );
			float e = 1.0e-10;
			return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 hsvTorgb3_g2 = RGBToHSV( _backgroundColor.rgb );
			float3 hsvTorgb4_g2 = HSVToRGB( float3(frac( ( _HueShift + hsvTorgb3_g2.x ) ),hsvTorgb3_g2.y,hsvTorgb3_g2.z) );
			float3 hsvTorgb3_g1 = RGBToHSV( _lineColor.rgb );
			float3 hsvTorgb4_g1 = HSVToRGB( float3(frac( ( _HueShift + hsvTorgb3_g1.x ) ),hsvTorgb3_g1.y,hsvTorgb3_g1.z) );
			float mulTime11 = _Time.y * _Speed;
			float3 lerpResult5 = lerp( hsvTorgb4_g2 , ( hsvTorgb4_g1 * _GlowPower ) , step( frac( ( ( i.uv_texcoord.y + mulTime11 ) * _LineNumber ) ) , _LineSize ));
			o.Emission = lerpResult5;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
-349.6;105.6;1178;665;1160.393;351.5242;1.37539;True;False
Node;AmplifyShaderEditor.RangedFloatNode;15;-1354.072,207.835;Inherit;False;Property;_Speed;Speed;3;0;Create;True;0;0;False;0;1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;11;-1180.123,204.0806;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1321.277,10.62573;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-1001.438,123.9892;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-941.101,267.9036;Inherit;False;Property;_LineNumber;LineNumber;2;0;Create;True;0;0;False;0;5;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-1104.97,-210.0305;Inherit;False;Property;_lineColor;lineColor;0;0;Create;True;0;0;False;0;0,0.9226117,1,0;0,0.9897842,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;21;-969.2145,-15.2417;Inherit;False;Property;_HueShift;HueShift;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-792.1805,165.2864;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;3;-1006.144,-448.2837;Inherit;False;Property;_backgroundColor;backgroundColor;1;0;Create;True;0;0;False;0;0.02865789,0.1411895,0.2641509,0;0.02865789,0.1411895,0.2641509,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-634.5004,446.858;Inherit;False;Property;_LineSize;LineSize;5;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;10;-632.2668,244.1263;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-418.0035,151.5207;Inherit;False;Property;_GlowPower;GlowPower;4;0;Create;True;0;0;False;0;3;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;20;-705.1396,-95.01426;Inherit;True;HueShift;-1;;1;bc172cf7ce5e65b4f9807b632deb225c;0;2;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;22;-657.0009,-372.843;Inherit;True;HueShift;-1;;2;bc172cf7ce5e65b4f9807b632deb225c;0;2;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-204.0092,23.87499;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StepOpNode;12;-424.2609,306.6978;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;5;9.022458,-107.7773;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;297.5829,-69.39604;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;enviro;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;11;0;15;0
WireConnection;9;0;1;2
WireConnection;9;1;11;0
WireConnection;13;0;9;0
WireConnection;13;1;14;0
WireConnection;10;0;13;0
WireConnection;20;1;4;0
WireConnection;20;2;21;0
WireConnection;22;1;3;0
WireConnection;22;2;21;0
WireConnection;16;0;20;0
WireConnection;16;1;17;0
WireConnection;12;0;10;0
WireConnection;12;1;18;0
WireConnection;5;0;22;0
WireConnection;5;1;16;0
WireConnection;5;2;12;0
WireConnection;0;2;5;0
ASEEND*/
//CHKSM=6BC2BBA76341020E591CF14CC02A16F681A6B845