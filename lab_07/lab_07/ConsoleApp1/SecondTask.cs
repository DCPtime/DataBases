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
        private XDocument xdoc = XDocument.Load("inner_xml.xml");
        public void readFromXML()
        {


            foreach (XElement element in xdoc.Elements("PersonalInformationRoot").Elements("PersonalInformation"))
            {
                XElement id = element.Element("Id");
                XElement nickname = element.Element("NickName");
                XElement first_name = element.Element("FirstName");
                XElement last_name = element.Element("LastName");
                XElement age = element.Element("AGE");
                XElement countries = element.Element("Countries");
                XElement country_name = countries.Element("Country");


                Console.WriteLine("ID игрока: " + id.Value);
                Console.WriteLine("Ник игрока: " + nickname.Value);
                Console.WriteLine("Имя игрока: " + first_name.Value);
                Console.WriteLine("Фамилия игрока: " + last_name.Value);
                Console.WriteLine("Возраст: " + age.Value);
                Console.WriteLine("Страна: " + country_name.Value);
                Console.WriteLine();

            }

        }

        public void updateXML()
        {
            var root = xdoc.Elements("PersonalInformationRoot");

            Console.WriteLine("\nВведите ID игрока, у которого хотите что-то изменить: ");
            var elementID = Console.ReadLine();

            Console.WriteLine("\nВведите название элемента, который хотите изменить: ");
            var elementTag= Console.ReadLine();

            Console.WriteLine("\nВведите новое значение элемента: ");
            var newElementValue = Console.ReadLine();

            foreach (XElement xe in root.Elements("PersonalInformation").ToList())
            {
                if (xe.Element("Id").Value == elementID)
                {
                    if (elementTag == "Country")
                    {
                        XElement countries = xe.Element("Countries");
                        countries.Element(elementTag).Value = newElementValue;
                    }
                    else
                    {
                        xe.Element(elementTag).Value = newElementValue;
                    }
                }
            }
            xdoc.Save("XML2.xml");
        }

        public void addToXML()
        {
            Console.Write("Введите ID игрока: ");
            var id = Console.ReadLine();

            Console.WriteLine();
            Console.Write("Введите ник игрока: ");
            var NickName = Console.ReadLine();

            Console.WriteLine();
            Console.Write("Введите имя игрока: ");
            var FirstName = Console.ReadLine();

            Console.WriteLine();
            Console.Write("Введите фамилию игрока: ");
            var LastName = Console.ReadLine();

            Console.WriteLine();
            Console.Write("Введите возраст игрока: ");
            var age = Console.ReadLine();

            Console.WriteLine();
            Console.Write("Введите Id страны, в которой живет игрок: ");
            var Country_id = Console.ReadLine();

            Console.WriteLine();
            Console.Write("Название страны: ");
            var Country_name = Console.ReadLine();

            xdoc.Element("PersonalInformationRoot").Add(new XElement("PersonalInformation",
                                  new XElement("id", id),
                                  new XElement("NickName", NickName),
                                  new XElement("FirstName", FirstName),
                                  new XElement("LastName", LastName),
                                  new XElement("AGE", age),
                                  new XElement("CountryId", Country_id),
                                  new XElement("Countries", new XElement("Id", Country_id), new XElement("Country", Country_name))
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
