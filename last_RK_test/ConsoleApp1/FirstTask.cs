using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    class Employees
    {
        public int Employee_id { get; set; }
        public string Employee_Name { get; set; }
        public string Position { get; set; }
        public int Age { get; set; }
        public int Salary { get; set; }
        public int Hours_per_week { get; set; }
    }

    class Employees1
    {
        public int Employee_id { get; set; }
        public string Employee_Name { get; set; }
        public string Position { get; set; }
        public int Age { get; set; }
        public int Salary { get; set; }
        public int Hours_per_week { get; set; }
    }

    class Employees_test
    {
        public int Employee_id_ { get; set; }
        public string Employee_Name_ { get; set; }
        public string Position_ { get; set; }
        public int Age_ { get; set; }
        public int Salary_ { get; set; }
        public int Hours_per_week_ { get; set; }
    }

    class FirstTask
    {
        public FirstTask()
        {
            IList<Employees> employees = new List<Employees>
            {
                new Employees() { Employee_id=1, Employee_Name="Ivan", Position="Manager", Age=30, Salary=100000, Hours_per_week= 40},
                new Employees() { Employee_id=2, Employee_Name="Tola", Position="Director", Age=30, Salary=180000, Hours_per_week= 50},
                new Employees() { Employee_id=3, Employee_Name="Polina", Position="Driver", Age=40, Salary=80000, Hours_per_week= 40},
                new Employees() { Employee_id=4, Employee_Name="Masha", Position="Manager", Age=40, Salary=100000, Hours_per_week= 40},
                new Employees() { Employee_id=5, Employee_Name="Misha", Position="Director", Age=50, Salary=180000, Hours_per_week= 50},
            };

            IList<Employees1> employees1 = new List<Employees1>
            {
                new Employees1() { Employee_id=1, Employee_Name="Ivan", Position="Manager", Age=40, Salary=120000, Hours_per_week= 40},
                new Employees1() { Employee_id=2, Employee_Name="Tola", Position="Director", Age=40, Salary=160000, Hours_per_week= 50},
                new Employees1() { Employee_id=3, Employee_Name="Polina", Position="Driver", Age=37, Salary=70000, Hours_per_week= 40},
                new Employees1() { Employee_id=4, Employee_Name="Masha", Position="Manager", Age=45, Salary=120000, Hours_per_week= 40},
                new Employees1() { Employee_id=5, Employee_Name="Misha", Position="Director", Age=45, Salary=160000, Hours_per_week= 50},
            };

            IList<Employees_test> employees3 = new List<Employees_test>
            {
                new Employees_test() { Employee_id_=1, Employee_Name_="Ivan", Position_="Manager", Age_=40, Salary_=120000, Hours_per_week_= 40},
                new Employees_test() { Employee_id_=2, Employee_Name_="Tola", Position_="Director", Age_=40, Salary_=160000, Hours_per_week_= 50},
                new Employees_test() { Employee_id_=3, Employee_Name_="Polina", Position_="Driver", Age_=37, Salary_=70000, Hours_per_week_= 40},
                new Employees_test() { Employee_id_=4, Employee_Name_="Masha", Position_="Manager", Age_=45, Salary_=120000, Hours_per_week_= 40},
                new Employees_test() { Employee_id_=5, Employee_Name_="Misha", Position_="Director", Age_=45, Salary_=160000, Hours_per_week_= 50},
            };

            // Вывод всех значений
            foreach (var i in employees)
                Console.WriteLine(i.Employee_id + " | " + i.Employee_Name + " | " + i.Age + " | " + i.Position + " | " + i.Position + " | " + i.Salary);


            Console.WriteLine();
            // 1. Работники старше 30 и с зарплатной  > 100000
            Console.WriteLine("1. Запрос: ");
            var _1result = from c in employees
                           let maxAge = 30
                           let midSalary = 100000
                           where (c.Age > maxAge && c.Salary > midSalary)
                           select c.Employee_Name;

            foreach (var i in _1result)
                Console.WriteLine(i);



            var result_que = from c in employees
                             let max_age = (from g in employees
                                            select g.Age).Average()
                             where c.Age > max_age
                             select c.Employee_Name;

            foreach (var i in result_que)
                Console.WriteLine("masdasd " + i);

            // Выбираем группы у работников по равной запрлате, и выбираем из них самого старшего
            var group_example = from c in employees
                                join c_2 in employees1 on c.Employee_id equals c_2.Employee_id
                                group c by c.Salary into new_group
                                select new
                                {
                                    first_coloumn = new_group.Key,
                                    second_column = new_group.Count(),
                                    Persons = from new_var in new_group
                                              let inner_max_age = (from new_var_2 in new_group
                                                                   select new_var_2.Age).Max()
                                              where new_var.Age == inner_max_age
                                              select new_var
                                };

            foreach (var i in group_example)
            {
                Console.WriteLine("salary = {0} count = {1}", i.first_coloumn, i.second_column);
                foreach (Employees inner_var in i.Persons)
                    Console.WriteLine(inner_var.Employee_Name);
            }

 







            Console.WriteLine();
            // 2. Возраст Ивана
            Console.WriteLine("2. Запрос: ");
            var _2result = from c in employees
                               where c.Employee_Name == "Ivan"
                               orderby c.Age descending
                               select $"Возраст Ivan {c.Age} лет";
                               
            foreach (var i in _2result)
                Console.WriteLine(i);

            Console.WriteLine();
           
            // 3. Запрос с OfType
            Console.WriteLine("3. Запрос: ");
            var _3result = from c in employees.OfType<Employees>()
                              select c.Employee_Name;

            foreach (var i in _3result)
                Console.WriteLine(i);


            Console.WriteLine();

            // 4. Имена - возраста работников
            Console.WriteLine("4. Запрос: ");
            var _4result = from c in employees
                               orderby c.Employee_Name, c.Age
                               select c;

            foreach (var i in _4result)
                Console.WriteLine(i.Employee_Name + " - " + i.Age);


            Console.WriteLine();
            // 5. Запрос group by
            Console.WriteLine("5. Запрос: ");
            var _5result = from c in employees
                           group c by c.Age into AgeGroup
                           select new { first = AgeGroup.Key, words = AgeGroup.Count() };

            foreach (var item in _5result)
                Console.WriteLine("Возраст {0} имеет {1} работников", item.first, item.words);

            Console.WriteLine();
            // 6. Запрос с join
            Console.WriteLine("6. Запрос: ");
            var _6result = from c in employees
                           join c1 in employees1 on c.Employee_id equals c1.Employee_id
                           select new { employeename = c.Employee_Name, employees1 = c1.Age };

            foreach (var item in _6result)
                Console.WriteLine("Работнику {0} {1} лет", item.employeename, item.employees1);
        }
    }
}
