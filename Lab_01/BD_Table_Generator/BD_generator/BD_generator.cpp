// BD_generator.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include "pch.h"
#include <iostream>

#include <cstdlib> // содержит srand() и rand()
#include <string>
#include <vector>
#include <set>  // заголовочный файл множеств и мультимножеств
#include <ctime> 
#include <math.h>
#include <fstream>

using namespace std;

void print_genre(set<string> &game_genre, int value, ofstream &fout)
{
	int clock = 0;
	for (std::set<std::string>::iterator it = game_genre.begin(); it != game_genre.end(); ++it)
	{
		if (value == clock)
		{
			cout << *it << ",   ";
			fout << *it << ",   ";
			break;
		}
		clock++;
	}
}

void print_style(int value, ofstream &fout)
{
	if (value == 0)
	{
		cout << "Agressive" << " ";
		fout << "Agressive" << " ";
	}
	else if (value == 1)
	{
		cout << "Defensive" << " ";
		fout << "Defensive" << " ";
	}
	else if (value == 2)
	{
		cout << "Middle" << " ";
		fout << "Middle" << " ";
	}
}


int get_random_int(int low_bord, int high_bord)
{
	return(low_bord + rand() % (abs(low_bord - high_bord) + 1));
}

void print_developer(set<string> &developer, int value, ofstream &fout)
{
	int clock = 0;
	for (std::set<std::string>::iterator it = developer.begin(); it != developer.end(); ++it)
	{
		if (value == clock)
		{
			cout <<  *it << ",   ";
			fout <<  *it << ",   ";
			break;
		}
		clock++;
	}
}

void print_game_names(set<string> &game_names, int value, ofstream &fout)
{
	int clock = 0;
	for (std::set<std::string>::iterator it = game_names.begin(); it != game_names.end(); ++it)
	{
		if (value == clock)
		{
			cout << *it << ",   ";
			fout << *it << ",   ";
			break;
		}
		clock++;
	}
}

void print_nick_names(set<string> &nick_names, int value, ofstream &fout)
{
	int clock = 0;
	for (std::set<std::string>::iterator it = nick_names.begin(); it != nick_names.end(); ++it)
	{
		if (value == clock)
		{
			cout << *it << ",   ";
			fout << *it << ",   ";
			break;
		}
		clock++;
	}
}


// Множим множество игр добавляя им новые части
void multmultiplication_game_names(set<string> &game_names, int amount)
{
	set<string> set_copy;

	set_copy = game_names;

	int clock = 2;
	for (int i = 2; i < amount + 2; i++)
	{
		for (std::set<std::string>::iterator it = set_copy.begin(); it != set_copy.end(); ++it)
		{

			string test = *it;
			test = test + " " + to_string(i);
			game_names.insert(test);
		}
	}
}

// Создаем имена
void get_nick_names(set<string> &nick_names, int amount, vector<string> &vector_names)
{
	while (nick_names.size() < amount)
	{
		string current_name_1 = vector_names[rand() % vector_names.size()];
		string current_name_2 = vector_names[rand() % vector_names.size()];
		string current_name_3 = vector_names[rand() % vector_names.size()];
		string current_name = current_name_1 + current_name_2 + current_name_3;
		nick_names.insert(current_name);
	}
}

// Генерируем данные для таблицы "игры"
void get_game_strings(int string_amount, set<string> &game_name,
	                  set<string> &game_genre, set<string> &developer, ofstream &fout)
{
	for (int i = 0; i < string_amount; i++)
	{
		cout << ", ";
		fout << ", ";
		print_game_names(game_name, i, fout);
		print_genre(game_genre, rand() % game_genre.size(), fout);
		print_developer(developer, rand() % developer.size(), fout);
		cout << get_random_int(1, 20) << ", ";
		fout << get_random_int(1, 20) << ", ";
		cout << get_random_int(1000, 2000000);
		fout << get_random_int(1000, 2000000);
		cout << endl;
		fout << endl;
	}
}

// Генерируем данные для таблицы "игроки"
void get_player_strings(int string_amount, set<string> &game_name,
	 set<string> &nick_name, ofstream &fout)
{
	for (int i = 0; i < string_amount; i++)
	{
		cout <<", ";
		fout <<", ";
		print_nick_names(nick_name, i, fout);
		cout << get_random_int(0, 100000) << ", ";
		fout << get_random_int(0, 100000) << ", ";
		cout << get_random_int(0, 5) << ", ";
		fout << get_random_int(0, 5) << ", ";
		print_game_names(game_name, rand() % game_name.size(), fout);
		print_style(rand() % 3, fout);
		cout << endl;
		fout << endl;

	}
}

// Генерируем данные для таблицы "персональные данные"
void get_person_strings(int string_amount, set<string> &nick_name, vector<string> &First_name,
	                    vector<string> & Last_name, vector<string> &country, ofstream &fout)
{
	for (int i = 0; i < string_amount; i++)
	{
		cout << ", ";
		fout << ", ";
		print_nick_names(nick_name, i, fout);
		cout << First_name[rand() % First_name.size()] << "," << "  ";
		fout <<First_name[rand() % First_name.size()] << "," << "  ";
		cout <<Last_name[rand() % Last_name.size()]  << "," << "  ";
		fout << Last_name[rand() % Last_name.size()]  << "," << "  ";
		cout << get_random_int(18, 40) << ", ";
		fout << get_random_int(18, 40) << ", ";
		cout << get_random_int(1, country.size());
		fout << get_random_int(1, country.size());
		cout << endl;
		fout << endl;

	}
}

void get_countries_strings(int string_amount, vector<string> &country, ofstream &fout)
{
	string_amount = country.size();
	for (int i = 0; i < string_amount; i++)
	{
		cout << ", ";
		fout << ", ";
		cout << country[i];
		fout << country[i];
		cout << endl;
		fout << endl;
	}
}

int main()
{
	srand(time(NULL));
	set<string> game_genre;
	game_genre.insert("Fighting");
	game_genre.insert("RTS");
	game_genre.insert("MOBA");
	game_genre.insert("FPS");
	game_genre.insert("Sport");
	game_genre.insert("Racing");

	set<string> developers;
	developers.insert("Alientrap");
	developers.insert("Babaroga");
	developers.insert("Cinemax");
	developers.insert("Croteam");
	developers.insert("Cypronia");
	developers.insert("Eurocom");
	developers.insert("Frogwares");
	developers.insert("Hexage");
	developers.insert("Jagex");
	developers.insert("Kloonigames");
	developers.insert("Llamasoft");

	set<string> game_names;
	game_names.insert("Battlefield");
	game_names.insert("Binaries");
	game_names.insert("Biomutant");
	game_names.insert("Call of Duty");
	game_names.insert("Candleman");
	game_names.insert("Chasm");
	game_names.insert("Chimparty");
	game_names.insert("Collectems");
	game_names.insert("DayZ");
	game_names.insert("Deiland");
	game_names.insert("Descenders");
	game_names.insert("Dogos");
	game_names.insert("Dollhouse");
	game_names.insert("Extinction");
	game_names.insert("Fibbage");
	game_names.insert("Flockers");
	game_names.insert("Forgotton");
	game_names.insert("FutureGrind");
	game_names.insert("HoPiKo");
	game_names.insert("Inversus");


	// Создаем никнеймы
	set<string> nick_names_set;
	vector<string> nick_names;
	nick_names.insert(nick_names.end(), "Dark");
	nick_names.insert(nick_names.end(), "White");
	nick_names.insert(nick_names.end(), "King");
	nick_names.insert(nick_names.end(), "Shoot");
	nick_names.insert(nick_names.end(), "Man");
	nick_names.insert(nick_names.end(), "Black");
	nick_names.insert(nick_names.end(), "Fast");
	nick_names.insert(nick_names.end(), "Light");
	nick_names.insert(nick_names.end(), "Rain");
	nick_names.insert(nick_names.end(), "Funny");
	nick_names.insert(nick_names.end(), "Rough");
	nick_names.insert(nick_names.end(), "Elder");
	nick_names.insert(nick_names.end(), "Spy");
	nick_names.insert(nick_names.end(), "Clerk");
	nick_names.insert(nick_names.end(), "Fat");
	nick_names.insert(nick_names.end(), "Thin");
	nick_names.insert(nick_names.end(), "Unfunny");
	nick_names.insert(nick_names.end(), "Smelling");
	nick_names.insert(nick_names.end(), "God");

	// Создаем Имена
	vector<string> First_names;
	First_names.insert(First_names.end(), "Alexey");
	First_names.insert(First_names.end(), "Andrey");
	First_names.insert(First_names.end(), "Mike");
	First_names.insert(First_names.end(), "Hiroto");
	First_names.insert(First_names.end(), "Max");
	First_names.insert(First_names.end(), "Danil");
	First_names.insert(First_names.end(), "Verondo");
	First_names.insert(First_names.end(), "Pavel");
	First_names.insert(First_names.end(), "David");
	First_names.insert(First_names.end(), "Duke");
	First_names.insert(First_names.end(), "Greg");
	First_names.insert(First_names.end(), "Irlando");
	First_names.insert(First_names.end(), "Johnny");
	First_names.insert(First_names.end(), "Sam");
	First_names.insert(First_names.end(), "Victor");
	First_names.insert(First_names.end(), "Tony");
	First_names.insert(First_names.end(), "William");
	First_names.insert(First_names.end(), "Wilson");
	First_names.insert(First_names.end(), "Ted");
	First_names.insert(First_names.end(), "Roy");

	// Создаем Фамилии
	vector<string> Last_names;
	Last_names.insert(Last_names.end(), "Ivanov");
	Last_names.insert(Last_names.end(), "Krasnov");
	Last_names.insert(Last_names.end(), "Petrov");
	Last_names.insert(Last_names.end(), "Anderson");
	Last_names.insert(Last_names.end(), "Babcock");
	Last_names.insert(Last_names.end(), "Birch");
	Last_names.insert(Last_names.end(), "Bush");
	Last_names.insert(Last_names.end(), "Cramer");
	Last_names.insert(Last_names.end(), "Daniels");
	Last_names.insert(Last_names.end(), "Derrick");
	Last_names.insert(Last_names.end(), "Dunce");
	Last_names.insert(Last_names.end(), "Farmer");
	Last_names.insert(Last_names.end(), "Fisher");
	Last_names.insert(Last_names.end(), "Sherlock");
	Last_names.insert(Last_names.end(), "Taylor");
	Last_names.insert(Last_names.end(), "Nagamoto");
	Last_names.insert(Last_names.end(), "Gilbert");

	// Создаем Страны
	vector<string> Countries;
	Countries.insert(Countries.end(), "Russia");
	Countries.insert(Countries.end(), "America");
	Countries.insert(Countries.end(), "Italy");
	Countries.insert(Countries.end(), "China");
	Countries.insert(Countries.end(), "Chad");
	Countries.insert(Countries.end(), "britain");
	Countries.insert(Countries.end(), "German");
	Countries.insert(Countries.end(), "Japan");
	Countries.insert(Countries.end(), "Zimbabwe");
	Countries.insert(Countries.end(), "Ukraine");
	Countries.insert(Countries.end(), "Brazil");
	Countries.insert(Countries.end(), "Romania");
	Countries.insert(Countries.end(), "Uganda");


	// Создаем файлы для вывода
	ofstream fout_games("games_info.txt");
	ofstream fout_players("players_info.txt");
	ofstream fout_personal("personal_info.txt");
	ofstream fout_countires_table("contires_info.txt");

	// Увеличиваем количество игр, добавляя им новые части
	multmultiplication_game_names(game_names, 4);
	// Получаем множество никнеймов из вектора примитивов
	get_nick_names(nick_names_set, 100, nick_names);




	// Получение таблицы о играх
	get_game_strings(100, game_names, game_genre, developers, fout_games);

	// Получение таблицы об игроках
	get_player_strings(100, game_names, nick_names_set, fout_players);

	// Получение таблицы о персональных данных
	get_person_strings(100, nick_names_set, First_names, Last_names, Countries, fout_personal);

	// Получение таблицы о странах
	get_countries_strings(100, Countries, fout_countires_table);

	fout_games.close();
	fout_players.close();
	fout_personal.close();
	fout_countires_table.close();
	
	system("pause");
}
