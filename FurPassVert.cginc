half3 GetMapNormal(inout appdata_full v)
{
	half3 wNormal = v.normal;
    half3 wTangent = v.tangent.xyz;
    half3 wBitangent = cross(wNormal, wTangent) * v.tangent.w;
    half3 tnormal = (tex2Dlod(_TangentMap, v.texcoord) - 0.5f) * 2;
    return half3(
        dot(half3(wTangent.x, wBitangent.x, wNormal.x), tnormal),
        dot(half3(wTangent.y, wBitangent.y, wNormal.y), tnormal),
        dot(half3(wTangent.z, wBitangent.z, wNormal.z), tnormal));
}

void vert (inout appdata_full v)
{    
	fixed3 vNormal = lerp(v.normal, GetMapNormal(v), _NormInf);
    
    half timeVal = fmod(_Time.y * _WindDir.w, 1);
	fixed3 forceDir = lerp(
        _Gravity.xyz * _Gravity.w, 
        _WindDir.xyz, 
        tex2Dlod(
            _WindCloud, 
            half4(v.texcoord.x + timeVal, timeVal, v.texcoord.z, v.texcoord.w)).x);

	v.vertex.xyz += 
        v.normal * 
        lerp(_Offset, _TipOffset, tex2Dlod(_HeightMap, v.texcoord).r) + 
        lerp(
            vNormal, 
            (forceDir) + vNormal * (1-_Gravity.w), 
            FUR_MULTIPLIER) * 
        lerp(_FurLengthMin, _FurLength, tex2Dlod(_MainTex, v.texcoord).w) * 
        FUR_MULTIPLIER * 
        v.color.a;
}