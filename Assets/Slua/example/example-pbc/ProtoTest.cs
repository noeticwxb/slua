﻿using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using SLua;
using System;


[CustomLuaClassAttribute]
public class ProtoTest : MonoBehaviour
{
	LuaSvr l;


	void Start()
	{
		l = new LuaSvr();
		l.init(null,()=>{l.start("protoTest");},LuaSvrFlag.LSF_BASIC | LuaSvrFlag.LSF_EXTLIB | LuaSvrFlag.LSF_3RDDLL);
	}

	void Update()
	{

	}

	public static ByteArray GetProtoBytes()
	{
		TextAsset at = Resources.Load("protoTest/addressbookBytes") as TextAsset;
		ByteArray pb = new ByteArray(at.bytes);
		return pb;
	}

	public static void SetProtoBytes( ByteArray pb )
	{
		Debug.Log( "proto bytes " + System.Text.Encoding.ASCII.GetString(pb.GetData()) );
	}

	public static string GetProtoTxt()
	{
		TextAsset at = Resources.Load("protoTest/addressbookBytes") as TextAsset;
		return at.text;
	}
}
