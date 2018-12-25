using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections;

namespace ConsoleApp1
{

    class People
    {
        public int id { get; set; }
        public string FIO { get; set; }
        public int salary { get; set; }
        public int age { get; set; }
    }

    class Purchases
    {
        public int id { get; set; }
        public string product_name { get; set; }
        public int units_amount { get; set; }
        public int cost { get; set; }
        public int people_id { get; set; }
    }


    class FirstTask
    {
        public FirstTask()
        {

            IList<People> People_list= new List<People>
            {
                new People() { id=1,  FIO="Ivan", salary=1000, age= 22},
                new People() { id=2,  FIO="Alexandr", salary=1000, age = 24},
                new People() { id=3,  FIO="Dmitry", salary=4000, age=34 },
                new People() { id=4,  FIO="Artem", salary=4000, age=33 },
                  new People() { id=5,  FIO="Alexey", salary=5000, age=40},
            };

            IList<Purchases> Purchases_list = new List<Purchases>
            {
                new  Purchases() { id=1,  product_name="product_1", units_amount=3,  cost=100, people_id =1},
                new  Purchases() { id=2,  product_name="product_2", units_amount=4,  cost=200, people_id =2},
                new  Purchases() { id=3,  product_name="product_3", units_amount=5,  cost=300, people_id =3},
                new  Purchases() { id=4,  product_name="product_4", units_amount=2,  cost=150, people_id =4},
                new  Purchases() { id=5,  product_name="product_5", units_amount=2,  cost=150, people_id =5},
            };

            ArrayList test_list = new ArrayList()
            {
                new  Purchases() { id=1,  product_name="product_1", units_amount=3,  cost=100, people_id =1},
                new  Purchases() { id=2,  product_name="product_2", units_amount=4,  cost=200, people_id =2},
                new  Purchases() { id=3,  product_name="product_3", units_amount=5,  cost=300, people_id =3},
                new  Purchases() { id=4,  product_name="product_4", units_amount=2,  cost=150, people_id =4},
                new  Purchases() { id=5,  product_name="product_5", units_amount=2,  cost=150, people_id =5},
                new People() { id=1,  FIO="Ivan", salary=1000, age= 22},
            };





            // Вывод всех значений
            foreach (var i in People_list)
            {
                Console.WriteLine("id = " + i.id + " | FIO = " + i.FIO + " | salary = " + i.salary
                    + " | age = " + i.age);
            }


            Console.WriteLine();
            // 1. Пукупки, стоимость которых больше среднего арифметического (использование переменной диапозона let)
            
            Console.WriteLine("1. Запрос: ");
            var _1result = from c in Purchases_list
                           let avg_limit = (from g in Purchases_list
                                            select g.units_amount * g.cost).Average()
                           where c.units_amount*c.cost > avg_limit
                           select c.product_name;

            foreach (var i in _1result)
                Console.WriteLine(i);


            Console.WriteLine();
            // 2. Группы по зарплате с максимальным возрастом в каждой (группировка)
            Console.WriteLine("2. Запрос: ");
            var group_example = from c in People_list
                                group c by c.salary into new_group
                                select new
                                {
                                    first_coloumn = new_group.Key,
                                    second_column = new_group.Count(),
                                    Persons = from new_var in new_group
                                              let inner_max_age = (from new_var_2 in new_group
                                                                   select new_var_2.age).Max()
                                              where new_var.age == inner_max_age
                                              select new_var
                                };



            foreach (var i in group_example)
            {
                Console.WriteLine("salary = {0} count = {1}", i.first_coloumn, i.second_column);
                foreach (People inner_var in i.Persons)
                    Console.WriteLine(inner_var.FIO);
            }

   

            Console.WriteLine();
            // 3. Запрос с OfType
            Console.WriteLine("3. Запрос: ");
            var _3result = test_list.OfType<Purchases>();

    

            foreach (Purchases i in _3result)
                Console.WriteLine(i.product_name);

            Console.WriteLine();
            // 4. Имена - возраста работников (двойная сортировка)
            Console.WriteLine("4. Запрос: ");
            var _4result = from c in People_list 
                               orderby c.salary, c.age descending
                           select c;

            foreach (var i in _4result)
                Console.WriteLine(i.FIO+ " has salary = " + i.salary + " with age = " + i.age);



            Console.WriteLine();
            // 5. Запрос с join (человек, совершивший самую дорогую покупку)
            Console.WriteLine("5. Запрос: ");
            var _6result = from c in People_list
                           join c1 in Purchases_list on c.id equals c1.people_id
                           let avg_limit = (from g in Purchases_list
                                            select g.units_amount * g.cost).Max()
                           where c1.cost * c1.units_amount == avg_limit
                           select new { name = c.FIO, purchase_summ = c1.units_amount*c1.cost };

            foreach (var item in _6result)
                Console.WriteLine(item.name + "  " + item.purchase_summ);
        }
    }
}
