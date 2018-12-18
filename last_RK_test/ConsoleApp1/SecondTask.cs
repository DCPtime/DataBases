using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Xml;
using System.Xml.Linq;


namespace ConsoleApp1
{
    class SecondTask
    {
        private XDocument xdoc = XDocument.Load("XML.xml");

        public void readFromXML()
        {
            foreach (XElement element in xdoc.Elements("Employees").Elements("Table_Employee"))
            {
                XElement Employee_id_Element = element.Element("Employee_id");
                XElement Employee_Name_Element = element.Element("Employee_Name");
                XElement Position_Element = element.Element("Position");
                XElement Age_Element = element.Element("Age");
                XElement Salary_Element = element.Element("Salary");
                XElement Hours_per_week_Element = element.Element("Hours_per_week");

                Console.WriteLine("ID работника: " + Employee_id_Element.Value);
                Console.WriteLine("Имя работника: " + Employee_Name_Element.Value);
                Console.WriteLine("Должность работника: " + Position_Element.Value);
                Console.WriteLine("Возраст работника: " + Age_Element.Value);
                Console.WriteLine("Зарплата работника: " + Salary_Element.Value);
                Console.WriteLine("Часов на работе в неделю: " + Hours_per_week_Element.Value);
                Console.WriteLine();
            }
        }

        public void updateXML()
        {
            var root = xdoc.Elements("Employees");

            Console.WriteLine("\nВведите ID работника, которого хотите изменить: ");
            var elementID = Console.ReadLine();

            Console.WriteLine("\nВведите название элемента, который хотите изменить: ");
            var elementTag= Console.ReadLine();

            Console.WriteLine("\nВведите новое значение элемента: ");
            var newElementValue = Console.ReadLine();

            foreach (XElement xe in root.Elements("Table_Employee").ToList())
            {
                if (xe.Element("Employee_id").Value == elementID)
                {
                    xe.Element(elementTag).Value = newElementValue;
                }
            }
            xdoc.Save("XML2.xml");
        }

        public void addToXML()
        {
            Console.Write("Введите ID работника: ");
            var Employee_id = Console.ReadLine();

            Console.WriteLine();
            Console.Write("Введите имя работника: ");
            var Employee_Name = Console.ReadLine();

            Console.WriteLine();
            Console.Write("Введите должность работника: ");
            var Position = Console.ReadLine();

            Console.WriteLine();
            Console.Write("Введите возраст работника: ");
            var Age = Console.ReadLine();

            Console.WriteLine();
            Console.Write("Введите зарплату работника: ");
            var Salary = Console.ReadLine();

            Console.WriteLine();
            Console.Write("Введите часы работы работника: ");
            var Hours_per_week = Console.ReadLine();

            xdoc.Element("Employees").Add(new XElement("Table_Employee",
                                  new XElement("Employee_id", Employee_id),
                                  new XElement("Employee_Name", Employee_Name),
                                  new XElement("Position", Position),
                                  new XElement("Age", Age),
                                  new XElement("Salary", Salary),
                                  new XElement("Hours_per_week", Hours_per_week)
                                  ));
            xdoc.Save("XML2.xml");
            Console.WriteLine("Сохранение выполнено успешно. Файл: XML2.xml");
        }

        public SecondTask()
        {
            bool flag = true;

            while (flag)
            {
                Console.WriteLine("\nМеню:");
                Console.WriteLine("0. Назад.");
                Console.WriteLine("1. Чтение из XML документа.");
                Console.WriteLine("2. Обновление XML документа.");
                Console.WriteLine("3. Запись (Добавление) в XML документ.");
                Console.Write("Ввод: ");

                var input = Console.ReadLine();
                switch (input)
                {
                    case "0":
                        flag = false;
                        break;
                    case "1":
                        readFromXML();
                        break;
                    case "2":
                        updateXML();
                        break;
                    case "3":
                        addToXML();
                        break;
                    default:
                        Console.WriteLine("Попробуйте еще раз.");
                        break;
                }
            }
        }
    }
}
