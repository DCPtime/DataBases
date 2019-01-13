using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace Lab_08
{
    class Tasks
    {
        //private readonly string connectionString = @"server = ; database = TitanicDB; user id = sa; password = ";
        private readonly string connectionString = @"Data Source=DESKTOP-4MPH77H; Initial Catalog=Cybersport; Integrated Security=True;";
        public void show_menu()
        {
            Console.WriteLine("Выберите пункт меню.");
            Console.WriteLine("Присоединенные:");
            Console.WriteLine("1) Показать данные о соединении.");
            Console.WriteLine("2) Вывод количества игроков с возрастом < 25");
            Console.WriteLine("3) Возврат строк");
            Console.WriteLine("4) Параметризованная вставка");
            Console.WriteLine("5) Вызов скалярной функции sql-server");
            Console.WriteLine("Отсоединенные:");
            Console.WriteLine("6) Извлечение и выборка данных");
            Console.WriteLine("7) Выборка с сортировкой");
            Console.WriteLine("8) Вставка");
            Console.WriteLine("9) Удаление");
            Console.WriteLine("10) Получение xml файла");
        }



        // Вывод информации о соединении (объект connection)
        public void connectedObjects_task_1_ConnectionString()
        {
            Console.WriteLine("".PadLeft(79, '-'));
            Console.WriteLine("Task #{0}: {1}", 1, "[Connected] Shows connection info.");

            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                connection.Open();
                Console.WriteLine("Connection has been opened.");
                Console.WriteLine("Connection properties:");
                Console.WriteLine("\tConnection string: {0}", connection.ConnectionString); // Методы класса SqlConnection
                Console.WriteLine("\tDatabase:          {0}", connection.Database);
                Console.WriteLine("\tData Source:       {0}", connection.DataSource);
                Console.WriteLine("\tServer version:    {0}", connection.ServerVersion);
                Console.WriteLine("\tConnection state:  {0}", connection.State);
                Console.WriteLine("\tWorkstation id:    {0}", connection.WorkstationId);
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the connection creating. Message: " + e.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        // Вывод количества игроков с возрастом < 25 (объект sqlcommand, метод ExecuteScalar)
        public void connectedObjects_task_2_SimpleScalarSelection()
        {
            Console.WriteLine("".PadLeft(79, '-'));
            Console.WriteLine("Task #{0}: {1}", 2, "[Connected] Simple scalar query.");

            string queryString = @"select count(*) from PersonalInformation where age < 25";
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand scalarQueryCommand = new SqlCommand(queryString, connection); // Создание объекта SqlCommand с использованием конструктора
                                                                                     // с параметрами
            Console.WriteLine("Sql command \"{0}\" has been created.", queryString);
            try
            {
                connection.Open();
                Console.WriteLine("Connection has been opened.");
                Console.WriteLine("-------->>> The count of players is {0}", scalarQueryCommand.ExecuteScalar()); // Вызов команды особым методом
                // (работает для sql-выражения + функции, встроенной в sql, например как count, min, sum)
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the sql command execution. Message: " + e.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        //  Возврат строк (объект DataReader и команда executeReader)
        public void connectedObjects_task_3_SqlCommand_SqlDataReader()
        {
            Console.WriteLine("".PadLeft(79, '-'));
            Console.WriteLine("Task #{0}: {1}", 3, "[Connected] DataReader for query.");

            string queryString = @"SELECT Games.GameName, Games.PlayerAmount
                                   FROM Games
                                   WHERE PlayerAmount BETWEEN 20000 AND 23000";
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand dataQueryCommand = new SqlCommand(queryString, connection);
            Console.WriteLine("Sql command \"{0}\" has been created.", queryString);
            try
            {
                connection.Open();
                Console.WriteLine("Connection has been opened.");
                SqlDataReader dataReader = dataQueryCommand.ExecuteReader(); // Получили объект DataReader, в котором построчно перебираем
                                                                             // строки таблицы (dataReader состоит из строк),
                                                                             // извлекая нужные нам данные

                Console.WriteLine("-------->>> Games with amount of players > 20000 and < 23000: ");
                while (dataReader.Read())
                {
                    Console.WriteLine("\t{0} {1}", dataReader.GetValue(0), dataReader.GetValue(1));
                }
                Console.WriteLine("-------->>> <<<-------");
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the sql command execution. Message: " + e.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        // Параметризованная команда (вставка и удаление данных из базы данных)
        public void connectedObjects_task_4_SqlCommandWithParameters()
        {
            Console.WriteLine("".PadLeft(79, '-'));
            Console.WriteLine("Task #{0}: {1}", 4, "[Connected] SqlCommand (Insert, Delete).");

            string countQueryString = @"select count(*) from Games";
            string insertQueryString = @"insert into Games(GameName, GameGenre, Developer, TournamenstAmount, PlayerAmount) 
                                         values (@GameName, @GameGenre, @Developer, @TournamenstAmount, @PlayerAmount)";

            string deleteQueryString = @"delete from Games where GameName = @GameName";

            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand countQueryCommand = new SqlCommand(countQueryString, connection);
            SqlCommand insertQueryCommand = new SqlCommand(insertQueryString, connection);
            SqlCommand deleteQueryCommand = new SqlCommand(deleteQueryString, connection);

            //parameters
            insertQueryCommand.Parameters.Add("@GameName", SqlDbType.VarChar, 50); // Указываем синтаксис слов, которые будут считаться параметрами
            insertQueryCommand.Parameters.Add("@GameGenre", SqlDbType.VarChar, 50);
            insertQueryCommand.Parameters.Add("@Developer", SqlDbType.VarChar, 50);
            insertQueryCommand.Parameters.Add("@TournamenstAmount", SqlDbType.Int);
            insertQueryCommand.Parameters.Add("@PlayerAmount", SqlDbType.Int);


            deleteQueryCommand.Parameters.Add("@GameName", SqlDbType.VarChar, 50);

            Console.WriteLine("Sql commands: \n1) \"{0}\"\n\n2) \"{1}\"\n\n3) \"{2}\"\n\nhas been created.\n", countQueryString, insertQueryString, deleteQueryString);
            try
            {
                connection.Open();
                Console.WriteLine("Connection has been opened.\n");
                Console.WriteLine("Current count of games: {0}\n", countQueryCommand.ExecuteScalar());
                Console.WriteLine("Inserting a new game. Input: ");
                Console.Write("- GameName = ");
                string GameName = Console.ReadLine();
                Console.Write("- GameGenre = ");
                string GameGenre = Console.ReadLine();
                Console.Write("- Developer = ");
                string Developer = Console.ReadLine();
                Console.Write("- TournamenstAmount = ");
                int TournamenstAmount = Convert.ToInt32(Console.ReadLine());
                Console.Write("- PlayerAmount = ");
                int PlayerAmount = Convert.ToInt32(Console.ReadLine());

                insertQueryCommand.Parameters["@GameName"].Value = GameName; // Назначаем параметрам в sql-выражениях значения
                insertQueryCommand.Parameters["@GameGenre"].Value = GameGenre;
                insertQueryCommand.Parameters["@Developer"].Value = Developer;
                insertQueryCommand.Parameters["@TournamenstAmount"].Value = TournamenstAmount;
                insertQueryCommand.Parameters["@PlayerAmount"].Value = PlayerAmount;
                deleteQueryCommand.Parameters["@GameName"].Value = GameName;

                Console.WriteLine("\nInsert command: {0}", insertQueryCommand.CommandText);
                insertQueryCommand.ExecuteNonQuery();
                Console.WriteLine("------>>> New count of games: {0}", countQueryCommand.ExecuteScalar());
                Console.WriteLine("------>>> Waiting to check. (readkey)");
                Console.ReadKey();
                Console.WriteLine();

                Console.WriteLine("Delete command: {0}", deleteQueryCommand.CommandText);
                deleteQueryCommand.ExecuteNonQuery();
                Console.WriteLine("------>>> New count of games: {0}", countQueryCommand.ExecuteScalar());
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the sql command execution. Message: " + e.Message);
            }
            catch (FormatException ex)
            {
                Console.WriteLine("Incorrect input data! " + ex.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        // Вызов функции (команда ExecuteNonQuery)
        public void connectedObjects_task_5_SqlCommand_StoredProcedure()
        {
            Console.WriteLine("".PadLeft(79, '-'));
            Console.WriteLine("Task #{0}: {1}", 5, "[Connected] Stored procedure.");

            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand storedProcedureCommand = connection.CreateCommand();
            storedProcedureCommand.CommandType = CommandType.StoredProcedure;
            storedProcedureCommand.CommandText = "Money_avg_per_tournament";

            Console.WriteLine("Sql command \"{0}\" has been created.", storedProcedureCommand.CommandText);
            try
            {
                connection.Open();
                Console.WriteLine("Connection has been opened.\n");

                Console.Write("Input the amount of prize money: ");
                int number = Convert.ToInt32(Console.ReadLine());
                Console.Write("Input the amount of tournaments: ");
                int tour_amount = Convert.ToInt32(Console.ReadLine());

                storedProcedureCommand.Parameters.Add("@amount_of_money", SqlDbType.Int).Value = number;
                storedProcedureCommand.Parameters.Add("@amount_of_tournaments", SqlDbType.Int).Value = tour_amount;

                var returnParameter = storedProcedureCommand.Parameters.Add("@ReturnVal", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;

                storedProcedureCommand.ExecuteNonQuery(); // Просто выполнение sql-выражения, возврат кол-ва измененных строк
                var result = returnParameter.Value;

                Console.WriteLine("------>>> {0}/{1} = {2}", number, tour_amount, result);
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the sql command execution. Message: " + e.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        // Извлечение и выборка данных на отключенном уровне
        public void disconnectedObjects_task_6_DataSetFromTable()
        {
            Console.WriteLine("".PadLeft(79, '-'));
            Console.WriteLine("Task #{0}: {1}", 6, "[Disconnected] DataSet from the table.");

            string query = @"select NickName, PrizeMoney from Players where PrizeMoney > 30000";

            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                connection.Open();
                Console.WriteLine("Connection has been opened.");

                SqlDataAdapter dataAdapter = new SqlDataAdapter(query, connection); // Adapter - посредник для заполнения DataSet данными
                DataSet dataSet = new DataSet();  // Хранилище данных, с которым работаем без подключения после его заполнения
                dataAdapter.Fill(dataSet); // Заполнили хранилище с помощью адаптера
                DataTable table = dataSet.Tables[0]; // Присваем объекту table класса DataTable ссылку на таблицу из хранилища

                Console.WriteLine("Successful players:");
                foreach (DataRow row in table.Rows)
                {
                    Console.Write("{0} ", row["NickName"]);
                    Console.Write(" ---- {0}\n", row["PrizeMoney"]);
                }
                Console.WriteLine();
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the sql query execution. Message: " + e.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        // Выборка с сортировкой на отключенном уровне
        public void disconnectedObjects_task_7_FilterSort()
        {
            Console.WriteLine("".PadLeft(79, '-'));
            Console.WriteLine("Task #{0}: {1}", 7, "[Disconnected] Filter and sort.");

            string query = @"select * from Players";
            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                connection.Open();
                Console.WriteLine("Connection has been opened.");

                SqlDataAdapter dataAdapter = new SqlDataAdapter(query, connection);
                DataSet dataSet = new DataSet();
                dataAdapter.Fill(dataSet);
                DataTableCollection tables = dataSet.Tables;

                Console.Write("Input minimum of champion count: ");
                int min_champ = Convert.ToInt32(Console.ReadLine());
                Console.WriteLine();

                string filter = "ChampionCount >" + min_champ;
                string sort = "PrizeMoney desc";
                Console.WriteLine("Playe who have >\"" + min_champ + "\" champion:");
                foreach (DataRow row in tables[0].Select(filter, sort))
                {
                    Console.Write("{0} ", row["Id"]);
                    Console.Write("{0} ", row["NickName"]);
                    Console.Write("{0} ", row["ChampionCount"]);
                    Console.Write("{0}\n", row["PrizeMoney"]);
                }
                Console.WriteLine();
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the sql query execution. Message: " + e.Message);
            }
            catch (FormatException ex)
            {
                Console.WriteLine("Incorrect input data! Message: " + ex.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        // Вставка на отключенном уровне
        public void disconnectedObjects_8_Insert()
        {
            Console.WriteLine("".PadLeft(79, '-'));
            Console.WriteLine("Task #{0}: {1}", 8, "[Disconnected] Insert.");

            string dataCommand = @"select * from Games where TournamenstAmount > 17";

            SqlConnection connection = new SqlConnection(connectionString);

            try
            {
                connection.Open();
                Console.WriteLine("Connection has been opened.");

                Console.WriteLine("Inserting a new game. Input: ");
                Console.Write("- GameName = ");
                string GameName = Console.ReadLine();
                Console.Write("- GameGenre = ");
                string GameGenre = Console.ReadLine();
                Console.Write("- Developer = ");
                string Developer = Console.ReadLine();
                Console.Write("- TournamenstAmount = ");
                int TournamenstAmount = Convert.ToInt32(Console.ReadLine());
                Console.Write("- PlayerAmount = ");
                int PlayerAmount = Convert.ToInt32(Console.ReadLine());



                SqlDataAdapter dataAdapter = new SqlDataAdapter(new SqlCommand(dataCommand, connection));
                DataSet dataSet = new DataSet();
                dataAdapter.Fill(dataSet);
                DataTable table = dataSet.Tables[0];

                // Создали, а затем заполнили новую строку для локальной таблицы
                DataRow insertingRow = table.NewRow();
                insertingRow["GameName"] = GameName;
                insertingRow["GameGenre"] = GameGenre;
                insertingRow["Developer"] = Developer;
                insertingRow["TournamenstAmount"] = TournamenstAmount;
                insertingRow["PlayerAmount"] = PlayerAmount;

                // добавили строку в локальную таблицу
                table.Rows.Add(insertingRow);

                Console.WriteLine("Games");
                foreach (DataRow row in table.Rows)
                {
                    Console.Write("{0} ", row["GameName"]);
                    Console.Write("{0} ", row["GameGenre"]);
                    Console.Write("{0} ", row["Developer"]);
                    Console.Write("{0} ", row["TournamenstAmount"]);
                    Console.Write("{0}", row["PlayerAmount"] + "\n");
                }





                SqlCommandBuilder commandBuilder = new SqlCommandBuilder(dataAdapter); // Здесь генерируются нужные sql выражения
                dataAdapter.Update(dataSet); // Здесь происходит анализ изменений в локальной и главной (которая в БД) таблицами и 
                                             // происходят изменения в зависимости от того, как изменилась локальная таблица
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the sql command execution. Message: " + e.Message);
            }
            catch (FormatException ex)
            {
                Console.WriteLine("incorrect input data! " + ex.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        public void disconnectedObjects_9_Delete()
        {
            Console.WriteLine("".PadLeft(79, '-'));
            Console.WriteLine("Task #{0}: {1}", 9, "[Disconnected] Delete.");

            string dataCommand = @"select * from Games where TournamenstAmount > 17";

            SqlConnection connection = new SqlConnection(connectionString);

            try
            {
                connection.Open();
                Console.WriteLine("Deleting the game. Input: ");
                Console.Write("- GameName = ");
                string GameName = Console.ReadLine();

                SqlDataAdapter dataAdapter = new SqlDataAdapter(new SqlCommand(dataCommand, connection));
                DataSet dataSet = new DataSet();
                dataAdapter.Fill(dataSet);
                DataTable table = dataSet.Tables[0];

                // Удаляем из локальной таблицы
                string filter = "GameName =  '" + GameName + "'";
                foreach (DataRow row in table.Select(filter))
                {
                    row.Delete();
                }

                // Удаляем из базы данных
                SqlCommandBuilder commandBuilder = new SqlCommandBuilder(dataAdapter); // Здесь генерируются нужные sql выражения
                dataAdapter.Update(dataSet); // Здесь происходит анализ изменений, которые произошли в локальной и глобальной (БД) таблицах

                Console.WriteLine("Games");
                foreach (DataRow row in table.Rows)
                {
                    Console.Write("{0} ", row["GameName"]);
                    Console.Write("{0} ", row["GameGenre"]);
                    Console.Write("{0} ", row["Developer"]);
                    Console.Write("{0} ", row["TournamenstAmount"]);
                    Console.Write("{0}", row["PlayerAmount"] + "\n");
                }
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the sql command execution. Message: " + e.Message);
            }
            catch (FormatException ex)
            {
                Console.WriteLine("Incorrect input data! " + ex.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        public void disconnectedObjects_10_Xml()
        {
            Console.WriteLine("".PadLeft(80, '-'));
            Console.WriteLine("Task #{0}: {1}", 10, "WriteXml.");

            string query = @"select * from Games";

            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                connection.Open();
                Console.WriteLine("Connection has been opened.");

                SqlDataAdapter dataAdapter = new SqlDataAdapter(query, connection);
                DataSet dataSet = new DataSet();
                dataAdapter.Fill(dataSet);
                DataTable table = dataSet.Tables[0];

                dataSet.WriteXml("games.xml");
                Console.WriteLine("Check the games.xml file.");
            }
            catch (SqlException e)
            {
                Console.WriteLine("There is a problem during the sql query execution. Message: " + e.Message);
            }
            finally
            {
                connection.Close();
                Console.WriteLine("Connection has been closed.");
            }
            Console.ReadLine();
        }

        static void Main(string[] args)
        {
            Tasks solution = new Tasks();
            int key = -1;
            while (key != 11)
            {
                switch (key)
                {
                    case 1:
                        solution.connectedObjects_task_1_ConnectionString();
                        key = -1;
                        break;
                    case 2:
                        solution.connectedObjects_task_2_SimpleScalarSelection();
                        key = -1;
                        break;
                    case 3:
                        solution.connectedObjects_task_3_SqlCommand_SqlDataReader();
                        key = -1;
                        break;
                    case 4:
                        solution.connectedObjects_task_4_SqlCommandWithParameters();
                        key = -1;
                        break;
                    case 5:
                        solution.connectedObjects_task_5_SqlCommand_StoredProcedure();
                        key = -1;
                        break;
                    case 6:
                        solution.disconnectedObjects_task_6_DataSetFromTable();
                        key = -1;
                        break;
                    case 7:
                        solution.disconnectedObjects_task_7_FilterSort();
                        key = -1;
                        break;
                    case 8:
                        solution.disconnectedObjects_8_Insert();
                        key = -1;
                        break;
                    case 9:
                        solution.disconnectedObjects_9_Delete();
                        key = -1;
                        break;
                    case 10:
                        solution.disconnectedObjects_10_Xml();
                        key = -1;
                        break;
                    default:
                        solution.show_menu();
                        key = Convert.ToInt32(Console.ReadLine());
                        break;

                }
            }
        }
    }
}

