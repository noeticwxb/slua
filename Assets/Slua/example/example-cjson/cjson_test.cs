﻿using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using SLua;
using System;


public class cjson_test : MonoBehaviour
{
	LuaSvr l;


	void Start()
	{
		l = new LuaSvr();
		l.init(null,()=>{l.start("cjsonTest");}, LuaSvrFlag.LSF_BASIC | LuaSvrFlag.LSF_EXTLIB | LuaSvrFlag.LSF_3RDDLL);
	}

	void Update()
	{

	}
}
