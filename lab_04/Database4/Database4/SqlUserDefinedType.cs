//------------------------------------------------------------------------------
// <copyright file="CSSqlUserDefinedType.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------
using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Text;


[Serializable]
[Microsoft.SqlServer.Server.SqlUserDefinedType(Format.Native)]
public struct vector: INullable
{
    private bool is_Null;
    private Int32 _x;
    private Int32 _y;

    
    public bool IsNull
    {
        get
        {
            // Введите здесь код
            return (is_Null);
        }
    }
    
    public static vector Null
    {
        get
        {
            vector current = new vector();
            current.is_Null = true;
            return current;
        }
    }

    public override string ToString()
    {
        if (this.is_Null)
            return "NULL";
        else
        {
            StringBuilder builder = new StringBuilder();
            builder.Append(_x);
            builder.Append(", ");
            builder.Append(_y);
            return builder.ToString();
        }
    }


    [SqlMethod(OnNullCall = false)]
    public static vector Parse(SqlString s)
    {
        if (s.IsNull)
            return Null;
        vector u = new vector();

        string[] xy = s.Value.Split(",".ToCharArray());
        u.x = Int32.Parse(xy[0]);
        u.y = Int32.Parse(xy[1]);
        return u;
    }

    public Int32 x
    {
        get
        {
            return this._x;
        }

        set
        {
            _x = value;
        }
    }

    public Int32 y
    {
        get
        {
            return this._y;
        }

        set
        {
            _y = value;
        }
    }

    [SqlMethod(OnNullCall = false)]
    public Double Scalar_mult_vector(vector pFrom)
    {
        return Scalar_mult(pFrom.x, pFrom.y);
    }

    [SqlMethod(OnNullCall = false)]
    public Double Scalar_mult(Int32 iX, Int32 iY)
    {
        return (iX*_x + iY*_y);
    }

}