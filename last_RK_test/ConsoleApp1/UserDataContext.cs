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
            
            [Function(Name = "GetDegree")]
            [return: Parameter(DbType = "Int")]
            public int GetDegree(
                [Parameter(Name = "Number", DbType = "Int")] ref int _Number,
                [Parameter(Name = "Degree", DbType = "Int")] ref int _Degree)
            {
                IExecuteResult result = this.ExecuteMethodCall(this, (MethodInfo)MethodInfo.GetCurrentMethod(), _Number, _Degree);
                _Number = (int)result.GetParameterValue(0);
                _Degree = (int)result.GetParameterValue(1);

                return (int)result.ReturnValue;
            }
        }
    }
}