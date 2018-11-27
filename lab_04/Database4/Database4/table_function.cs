using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Collections;

public partial class SqlServerUDF
{
    [Microsoft.SqlServer.Server.SqlFunction(FillRowMethodName = "FillRow",
           TableDefinition = "word_1 nchar(1), spaces_amount int, word_2 nchar(1)")]
    public static IEnumerable my_table_function(string InputName)
    {
        yield return new NameRow(InputName, InputName.Split(' ').Length - 1, InputName.Replace(" ", string.Empty));
    }

    public static void FillRow(object row, out SqlString word_1, out int len, out SqlString word_2)
    {
        // Разбор строки на отдельные столбцы. 
        word_1 = ((NameRow)row).word_1;
        len = ((NameRow)row).len;
        word_2 = ((NameRow)row).word_2;
    }
}

public class NameRow
{
    public SqlString word_1;
    public Int32 len;
    public SqlString word_2;

    public NameRow(SqlString c_1, Int32 i, SqlString c_2)
    {
        word_1 = c_1;
        len = i;
        word_2 = c_2;
    }
}

