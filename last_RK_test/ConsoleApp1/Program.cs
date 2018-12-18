using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                bool flag = true;

                while (flag)
                {
                    Console.WriteLine("\nМеню:");
                    Console.WriteLine("0. Выход");
                    Console.WriteLine("1. Обычные запросы");
                    Console.WriteLine("2. Запросы LINQ с XML");
                    Console.WriteLine("3. Запросы LINQ с SQL");
                    Console.Write("Ввод: ");

                    var input = Console.ReadLine();
                    switch (input)
                    {
                        case "0":
                            flag = false;
                            break;
                        case "1":
                            FirstTask first = new FirstTask();
                            break;
                        case "2":
                            SecondTask second = new SecondTask();
                            break;
                        case "3":
                            ThirdTask third = new ThirdTask();
                            break;
                        default:
                            Console.WriteLine("Попробуйте еще раз.");
                            break;
                    }
                }
            }
            catch (Exception ex)
            {

                Console.WriteLine("Ошибка. " + ex.Message);
            }
            Console.ReadKey();
        }

    }
}
