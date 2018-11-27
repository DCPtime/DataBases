//------------------------------------------------------------------------------
// <copyright file="CSSqlStoredProcedure.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------
using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

public partial class StoredProcedures
{
    [Microsoft.SqlServer.Server.SqlProcedure]
    public static void stored_proc (string developer_name)
    {
        using (SqlConnection contextConnection = new SqlConnection("context connection = true"))
        {
            SqlCommand contextCommand =
               new SqlCommand(
               "Select AVG(PlayerAmount) AS Avg_amount_of_players from Games " +
               "where Developer = @name", contextConnection);

            contextCommand.Parameters.AddWithValue("@name", developer_name);
            contextConnection.Open();

            SqlContext.Pipe.ExecuteAndSend(contextCommand);
        }
    }
}
