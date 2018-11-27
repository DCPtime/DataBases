//------------------------------------------------------------------------------
// <copyright file="CSSqlAggregate.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------
using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

[Serializable]
[Microsoft.SqlServer.Server.SqlUserDefinedAggregate(Format.Native)]
public struct my_aggregate: IBinarySerialize
{
    // Поле элемента заполнителя
    private int result;

    public void Init()
    {
        result = 0;
    }

    public void Accumulate(SqlInt32 Value)
    {
        if (Value > 5)
            result++;
    }

    public void Merge (my_aggregate Group)
    {
        result += Group.result;
    }

    public SqlInt32 Terminate ()
    {
        // Введите здесь код
        return new SqlInt32(result);
    }

    public void Read(System.IO.BinaryReader r)
    {
        result = r.ReadInt32();
    }

    public void Write(System.IO.BinaryWriter w)
    {
        w.Write(result);
    }


}
