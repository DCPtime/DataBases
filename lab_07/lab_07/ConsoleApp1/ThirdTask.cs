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
            string connectionString = @"Data Source=DESKTOP-4MPH77H; Initial Catalog=Cybersport; Integrated Security=True;";
            DataContext db = new DataContext(connectionString);

            // 1.
            Console.WriteLine("\nОднотабличный запрос на выборку.");
            var players_select = from p in db.GetTable<Players>()
                         where p.PrizeMoney > 30000
                                 select p;

            
            Console.WriteLine("Ники игроков, которые выиграли больше 30000: ");
            foreach (var i in players_select)
                Console.WriteLine(i.NickName);

            
            
            // 2. Выбираем  фамилию, имя и страну из тех игроков, кто живет в Америке или в России
            Console.WriteLine();
            Console.WriteLine("\nМноготабличный запрос на выборку");
            var p_and_c = from person in db.GetTable<PersonalInformation>()
                           join country in db.GetTable<Countries>() on person.CountryId equals country.id
                          //select new { Machineid = machine.Machine_id, MachineType = machine.Machine_Type, EmployeeName = employee.Employee_Name }
                           where country.id == 1 || country.id == 2
                           select new
                           {
                               FirstName = person.FirstName, LastName = person.LastName, Country = country.Country
                           };

    

            Console.WriteLine("Игроки и их страны: ");
            foreach (var i in p_and_c)
                Console.WriteLine(i.FirstName + i.LastName + "  from " + i.Country);



            // 3.

            
            // Добавление
            
            Console.WriteLine("Добавление новой записи");
            Console.Write("Введите название игры:");
            var GameName = Console.ReadLine();
            Console.Write("Введите жанр игры:");
            var GameGenre = Console.ReadLine();
            Console.Write("Введите название компании-разработчка:");
            var Developer = Console.ReadLine();

            Console.Write("Введите количество турниров:");
            var tournament_amount = Convert.ToInt32(Console.ReadLine());

            Console.Write("Введите количество игроков, играющих в эту игру:");
            var players_amount = Convert.ToInt32(Console.ReadLine());
            

            var IDs = from i in db.GetTable<Games>()
                      select i.id;

             

            
            Games new_game = new Games()
            {
                GameName = GameName,
                GameGenre = GameGenre,
                Developer = Developer,
                TournamenstAmount = tournament_amount,
                PlayerAmount = players_amount
            };

            db.GetTable<Games>().InsertOnSubmit(new_game);
            db.SubmitChanges();
            Console.WriteLine("Добавление выполенено успешно");
            


            // Изменение             Console.WriteLine("\n\nИзменение записи в таблице ");
            Console.WriteLine("Введите новое имя для игры: ");
            var newValue = Console.ReadLine();

            int maxID = IDs.Max();
            var changeDB = db.GetTable<Games>().Where(e => e.id == maxID).FirstOrDefault();
            changeDB.GameName = newValue;
            db.SubmitChanges();
            Console.WriteLine("Изменение выполенено");


            
            Console.ReadKey();
            


            // Удаление
            Console.WriteLine("\n\nУдаление последней записи в таблице ");
            var delDB = db.GetTable<Games>().Where(e => e.id == maxID).FirstOrDefault();
            db.GetTable<Games>().DeleteOnSubmit(delDB);
            db.SubmitChanges();
            Console.WriteLine("Удаление выполенено");
            
            

            
            // Получение доступа к данным, выполняя только хранимую процедуру.
            UserDataContext.UserDataContext1 db1 = new UserDataContext.UserDataContext1(connectionString);
            int _Number_1, _Number_2;
            
            Console.WriteLine("Хранимая процедура: ");
            Console.WriteLine("\nВведите первое число:");
            _Number_1 = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("\nВведите второе число:");
            _Number_2 = Convert.ToInt32(Console.ReadLine());

            var obj = db1.GetSumm(ref _Number_1, ref _Number_2);
            Console.WriteLine("\nРезультат разности квадратов: " + obj);
            
        }
    }
}
