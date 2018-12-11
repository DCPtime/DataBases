using System;
using System.Xml;    
using System.IO;



namespace lab_06
{
    class consoleApp
   {
        public static void Print_info()
        {
            Console.Write("Input 2 for searchig information\n");
            Console.Write("Input 3 for access to nodes\n");
            Console.Write("Input 4 for document changes\n");
        }
        

        static void Main(string[] args)
      {
            int read_param = -1; // Для консоли

            // 1. Чтение документа
            XmlDocument myDocument = new XmlDocument();
            FileStream myFile = new FileStream("../../personal_xml.xml", FileMode.Open);
            myDocument.Load(myFile);

            while (read_param != 0)
            {
                Print_info();
                read_param = int.Parse(Console.ReadLine());


                if (read_param == 2)
                {
                    // 2. Поиск информации в документе

                    // Вывод всех ников
                    //Здесь nick_names[i] - element с Name = Nickname, а childNode - уже конкретный ник
                    Console.Write("These nicknames were found:\r\n");
                    XmlNodeList nick_names = myDocument.GetElementsByTagName("NickName");
                    for (int i = 0; i < nick_names.Count; i++)
                        Console.Write(nick_names[i].ChildNodes[0].Value + "\r\n");



                    // Вывод ника человека с ID = 1
                    // Здесь current_element - Name = PersonalInformation, а далее как выше
                    Console.Write("\n\nThis player has ID = 2:\r\n");
                    XmlElement current_element = myDocument.GetElementById("2");
                    Console.Write(current_element.ChildNodes[0].ChildNodes[0].Value + "\r\n");


                    // Вывод возрастов людей, которые живут в России
                    Console.Write("\n\nAges of players who live in russia:\r\n");
                    XmlNodeList age = myDocument.SelectNodes("//PersonalInformation/AGE/text()[../../CountryId/text()='1']");
                    for (int i = 0; i < age.Count; i++)
                        Console.Write(age[i].Value + "\r\n");


                    // Вывод возраста первого попавшегося человека, живущего в России
                    Console.Write("\n\nAge of the first player who live in russia is:\r\n");
                    XmlNode OnlyOneAge = myDocument.SelectSingleNode("//PersonalInformation/AGE/text()[../../CountryId/text()='1']");
                    Console.Write(OnlyOneAge.Value + "\r\n");
                }



                if (read_param == 3)
                {
                    // 3. Доступ к узлам
                    
                    // Доступ к элементу
                    Console.Write("\n\n" + myDocument.DocumentElement.ChildNodes[0].Value + "\r\n");

                    // Получаем текстовые значения + комментарии
                    Console.Write("\n\nInformation about players \n");
                    XmlNodeList pass = myDocument.GetElementsByTagName("PersonalInformation");
                    for (int i = 0; i < pass.Count; i++)
                        Console.Write(pass[i].ChildNodes[1].InnerText + " " + pass[i].ChildNodes[5].Value + "\r\n");


                    // XML <xsl>
                    XmlProcessingInstruction instruc = (XmlProcessingInstruction)myDocument.DocumentElement.ChildNodes[0];
                    Console.Write("\n\nInstruction: \n Name: " + instruc.Name + "\r\n");
                    Console.Write("Data: " + instruc.Data + "\r\n");


                    // Атрибуты узлов
                    Console.Write("\n\nIDs of Players: \n");
                    for (int i = 0; i < pass.Count; i++)
                        Console.Write(pass[i].ChildNodes[1].InnerText + " : " + pass[i].Attributes[0].Value + "\r\n");
                }

                if (read_param == 4)
                {
                    XmlNodeList pass = myDocument.GetElementsByTagName("PersonalInformation");

                    //4. Изменение файлов

                    // Удаление
                    XmlElement pcElement = (XmlElement)myDocument.GetElementsByTagName("AGE")[0];
                    pass[0].RemoveChild(pcElement);
                    Console.Write("Delete the first player age..." + "\r\n");
                    myDocument.Save("../../my_task-del.xml");

                    // Изменение содержимого
                    XmlNodeList ageValues = myDocument.SelectNodes("//PersonalInformation/LastName/text()");
                    for (int i = 0; i < ageValues.Count; i++)
                        ageValues[i].Value = ageValues[i].Value + " addition_par";
                    Console.Write("Change last names" + "\r\n");
                    myDocument.Save("../../my_task-chg.xml");

                    // Создание и вставка нового PersonalInformation
                    XmlElement PassElement = myDocument.CreateElement("PersonalInformation");
                    XmlElement NickNameElement = myDocument.CreateElement("NickName");
                    XmlElement FistNameElement = myDocument.CreateElement("FirstName");
                    XmlElement SecondNameElement = myDocument.CreateElement("LastName");
                    XmlElement AgeElement = myDocument.CreateElement("AGE");
                    XmlElement CountryElement = myDocument.CreateElement("CountryId");

                    XmlText NickNameText = myDocument.CreateTextNode("9pasha");
                    XmlText FistNameText = myDocument.CreateTextNode("First_name");
                    XmlText SecondNameText = myDocument.CreateTextNode("Last_name");
                    XmlText AgeText = myDocument.CreateTextNode("30");
                    XmlText CountryText = myDocument.CreateTextNode("2");


                    NickNameElement.AppendChild(NickNameText);
                    FistNameElement.AppendChild(FistNameText);
                    SecondNameElement.AppendChild(SecondNameText);
                    AgeElement.AppendChild(AgeText);
                    CountryElement.AppendChild(CountryText);

                    PassElement.AppendChild(NickNameElement);
                    PassElement.AppendChild(FistNameElement);
                    PassElement.AppendChild(SecondNameElement);
                    PassElement.AppendChild(AgeElement);
                    PassElement.AppendChild(CountryElement);

                    myDocument.DocumentElement.AppendChild(PassElement);
                    Console.Write("Add new personal_inform" + "\r\n");
                    myDocument.Save("../../my_task-new.xml");

                    //  Добавление атрибутов
                    XmlDocument newDocument = new XmlDocument();
                    FileStream newFile = new FileStream("../../my_task-new.xml", FileMode.Open);
                    newDocument.Load(newFile);

                    XmlElement newElement = (XmlElement)myDocument.GetElementsByTagName("PersonalInformation")[3];
                    newElement.SetAttribute("_id", "10");
                    Console.Write("set attribute" + "\r\n");
                    myDocument.Save("../../my_task-attr.xml");

                    newFile.Close();
                    myFile.Close();
                }

                Console.Write('\n');
            }


         
      }
   }
}
