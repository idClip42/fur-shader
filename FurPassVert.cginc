half3 GetMapNormal(inout appdata_full v)
{
	half3 wNormal = v.normal;
    half3 wTangent = v.tangent.xyz;
    half3 wBitangent = cross(wNormal, wTangent) * v.tangent.w;
    half3 tnormal = (tex2Dlod(_Normals, v.texcoord) - 0.5f) * 2;
    return half3(
        dot(half3(wTangent.x, wBitangent.x, wNormal.x), tnormal),
        dot(half3(wTangent.y, wBitangent.y, wNormal.y), tnormal),
        dot(half3(wTangent.z, wBitangent.z, wNormal.z), tnormal));
}

half GetPercentage()
{
    return lerp(FUR_MULTIPLIER, 1 - pow(1-FUR_MULTIPLIER,2), _ThicknessCurve);
}

void vert (inout appdata_full v)
{
    half3 mapNormal = GetMapNormal(v);
	fixed3 vNormal = lerp(v.normal, mapNormal, _NormInf);
    
    half timeVal = fmod(_Time.y * _WindDir.w, 1);
	fixed3 forceDir = lerp(
        lerp(_Gravity.xyz, mapNormal, _NormInfTip) * _Gravity.w, 
        _WindDir.xyz, 
        tex2Dlod(
            _WindCloud, 
            half4(v.texcoord.x + timeVal, timeVal, v.texcoord.z, v.texcoord.w)).x);
            
	half perc = GetPercentage();

	v.vertex.xyz += 
        v.normal * _Offset + 
        lerp(
            vNormal, 
            (forceDir) + vNormal * (1-_Gravity.w), 
            perc) * 
        lerp(_FurLengthMin, _FurLength, tex2Dlod(_MainTex, v.texcoord).w) * 
        perc * 
        v.color.a;
}