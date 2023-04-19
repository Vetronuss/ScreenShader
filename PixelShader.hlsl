// THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
// ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
// PARTICULAR PURPOSE.
//
// Copyright (c) Microsoft Corporation. All rights reserved
//----------------------------------------------------------------------

Texture2D tx : register( t0 );
SamplerState samLinear : register( s0 );

struct PS_INPUT
{
    float4 Pos : SV_POSITION;
    float2 Tex : TEXCOORD;
};

//--------------------------------------------------------------------------------------
// Pixel Shader
//--------------------------------------------------------------------------------------
// Input structure



float4 PS(PS_INPUT input) : SV_Target
{
    // Define texel size
    float2 texelSize = 1.0 / float2(2560, 1440); // Replace with your actual screen resolution or the desired resolution
    if (input.Tex.x > 0.3)
    {
        return tx.Sample(samLinear, input.Tex + float2(0.0, 0.0));
    }
    // Calculate average color
    float4 color = tx.Sample(samLinear, input.Tex + float2(-texelSize.x, 0.0));
    color += tx.Sample(samLinear, input.Tex + float2(texelSize.x, 0.0));
    color += tx.Sample(samLinear, input.Tex + float2(0.0, -texelSize.y));
    color += tx.Sample(samLinear, input.Tex + float2(0.0, 0.0));
    color += tx.Sample(samLinear, input.Tex + float2(0.0, texelSize.y));
    color /= 5.0;


    return color;
}