using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Data.SqlClient;
using System.Data.Linq;
using System.Data.Linq.Mapping;
using System.Reflection;

namespace ConsoleApp1
{
    public class UserDataContext
    {
        public class UserDataContext1 : DataContext
        {
            public UserDataContext1(string connectionString) : base(connectionString)
            {

            }
            
            [Function(Name = "GetSumm")]
            [return: Parameter(DbType = "Int")]
            public int GetSumm(
                [Parameter(Name = "A", DbType = "Int")] ref int _Number_1,
                [Parameter(Name = "B", DbType = "Int")] ref int _Number_2)
            {
                IExecuteResult result = this.ExecuteMethodCall(this, (MethodInfo)MethodInfo.GetCurrentMethod(), _Number_1, _Number_2);
                //_Number_1 = (int)result.GetParameterValue(0);
                //_Number_2 = (int)result.GetParameterValue(1);

                return (int)result.ReturnValue;
            }
        }
    }
}