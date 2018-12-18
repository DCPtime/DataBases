using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Data.SqlClient;
using System.Data.Linq.Mapping;

namespace ConsoleApp1
{
    [Table (Name = "Table_Employee")]
    public class Table_Employee
    {
        [Column (IsPrimaryKey = true)]
        public int Employee_id { get; set; }

        [Column]
        public string Employee_Name { get; set; }

        [Column]
        public string Position { get; set; }

        [Column]
        public int Age { get; set; }

        [Column]
        public int Salary { get; set; }

        [Column]
        public int Hours_per_week { get; set; }
    }

    [Table (Name = "Table_Machine")]
    public class Table_Machine
    {
        [Column (IsPrimaryKey = true)]
        public int Machine_id { get; set; }

        [Column]
        public string Machine_Type { get; set; }

        [Column]
        public string Machine_State { get; set; }

        [Column]
        public int Number { get; set; }
    }

    [Table (Name = "Table_Mine")]
    public class Table_Mine
    {
        [Column (IsPrimaryKey = true)]
        public int Mine_id { get; set; }

        [Column]
        public string Mine_Type { get; set; }

        [Column]
        public int Ore_value { get; set; }

        [Column]
        public int Ore_amount { get; set; }

    }

    [Table (Name= "Directory_Work")]
    public class Directory_Work
    {
        [Column (IsPrimaryKey = true)]
        public int Work_id { get; set; }

        [Column]
        public string Work_Type { get; set; }
    }
}
