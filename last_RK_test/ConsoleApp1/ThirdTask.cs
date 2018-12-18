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
    class ThirdTask
    {
       
        public ThirdTask()
        {
            string connectionString = @"Data Source=DESKTOP-T7HU8QC;Initial Catalog=Mining_company; Integrated Security=True";
            DataContext db = new DataContext(connectionString);

            // 1.
            Console.WriteLine("\nОднотабличный запрос на выборку.");
            var employees = from p in db.GetTable<Table_Employee>()
                         where p.Age == 30
                         select p;

            Console.WriteLine("Имена работников которым 30 лет: ");
            foreach (var employee in employees)
                Console.WriteLine(employee.Employee_Name);


            // 2.
            Console.WriteLine();
            Console.WriteLine("\nМноготабличный запрос на выборку");
            var machines = from machine in db.GetTable<Table_Machine>()
                       join employee in db.GetTable<Table_Employee>() on machine.Machine_id equals employee.Employee_id
                           select new { Machineid = machine.Machine_id, MachineType = machine.Machine_Type, EmployeeName = employee.Employee_Name };

            Console.WriteLine("Работники и их машины: ");
            foreach (var machine in machines)
                Console.WriteLine(machine);


            // 3.
            
            // Добавление
            Console.WriteLine("Добавление новой записи");
            Console.Write("Введите имя работника:");
            var employee_name = Console.ReadLine();
            Console.Write("Введите должность работника:");
            var position = Console.ReadLine();
            Console.Write("Введите возраст работника:");
            var age = Convert.ToInt32(Console.ReadLine());
            var IDs = from employee in db.GetTable<Table_Employee>()
                      select employee.Employee_id;

            int maxID = IDs.Max() + 1;

            Table_Employee newEmployee = new Table_Employee()
            {
                Employee_id = maxID,
                Employee_Name = employee_name,
                Position = position,
                Age = age
            };
            db.GetTable<Table_Employee>().InsertOnSubmit(newEmployee);
            db.SubmitChanges();
            Console.WriteLine("Добавление выполенено успешно");

            // Изменение             Console.WriteLine("\n\nИзменение записи в таблице ");
            Console.WriteLine("Введите новое имя работника: ");
            var newValue = Console.ReadLine();

            var changeDB = db.GetTable<Table_Employee>().Where(e => e.Employee_id == maxID).FirstOrDefault();
            changeDB.Employee_Name = newValue;
            db.SubmitChanges();
            Console.WriteLine("Изменение выполенено");

            Console.ReadKey();

            // Удаление
            Console.WriteLine("\n\nУдаление записи в таблице ");
            var delDB = db.GetTable<Table_Employee>().Where(e => e.Employee_id == maxID).FirstOrDefault();
            db.GetTable<Table_Employee>().DeleteOnSubmit(delDB);
            db.SubmitChanges();
            Console.WriteLine("Удаление выполенено");

            
            // Получение доступа к данным, выполняя только хранимую процедуру.
            UserDataContext.UserDataContext1 db1 = new UserDataContext.UserDataContext1(connectionString);
            int _Number, _Degree;
            
            Console.WriteLine("Хранимая процедура: ");
            Console.WriteLine("\nВведите число:");
            _Number = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("\nВведите степень:");
            _Degree = Convert.ToInt32(Console.ReadLine());

            var obj = db1.GetDegree(ref _Number, ref _Degree);
            Console.WriteLine($"Число: {_Number}, \nСтепень: {_Degree}. \nРезультат: " + obj);
        }
    }
}
