﻿//------------------------------------------------------------------------------
// <copyright file="CSSqlFunction.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------
using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

public partial class SqlServerUDF
{
    [Microsoft.SqlServer.Server.SqlFunction]
    public static SqlInt32 GetRandomNumber()
    {
        Random rnd = new Random();
        return rnd.Next();
    }
}