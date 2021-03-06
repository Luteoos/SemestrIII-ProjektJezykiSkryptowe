// CountSort.cpp : Defines the entry point for the console application.
//
//Zakladamy ze pliki wejsciowe sa skonfigurowne w odpowiedni sposob, tj. nie konczą się lub nie zaweirają pustej lini.
#include "stdafx.h"

using namespace std;


fstream input;
fstream output;
int highest = 0;//najwiekszy element w pliku
int N = 0; //ilosc danych wejsciowych dla algorytmu

void Sort(int Input[], int Output[], int size);

int main(int argc, char * argv[])
{
	string x;
	if (argc == 1)
	{
		cerr << "no input detected";// brak argumentow startowych
		return-10;
	}

	input.open(argv[1], ios::in);
	auto timestart = chrono::high_resolution_clock::now();//timestamp dla startu algorytmu

	if (input.good() == true)//sprawdzaa input
	{
		while (!input.eof())//zlicza ilosc danych w input
		{
			getline(input, x);
			N++;
		}
		int *inputmatrix = new int[N]; //tworzy tablice danych wejsciowych
		int *outputmatrix = new int[N];//Tablica posegragowanych danych wyjsciowych
		input.seekg(0);//ustawia plik znowu od poczatku

		int i = 0;
		while (!input.eof())//szuka najwyzszej wartosci input i wczytuje do tablicy 
		{
			input >> inputmatrix[i];
			if (inputmatrix[i] > highest)
			{
				highest = inputmatrix[i];
			}
			i++;
		}
		i--;//ustawia i na "ostatni elemt" w tablicy 
		
		input.close();//zamyka input
		Sort(inputmatrix, outputmatrix, N);//uruchamia algorytm
		delete[]inputmatrix;
		
		auto timeend = chrono::high_resolution_clock::now();//timestamp dla konca algorytmu, tablica juz posegregowana 
		auto timedif = 1.e-6*chrono::duration_cast<std::chrono::nanoseconds>(timeend - timestart).count();//czas jaki zajal algorytm w ms

		output.open(argv[2], ios::out);//otwiera plik output, podany na 2 pozycji listy argumentow
		if (output.good() == true)//sprawdza plik output
		{
			output << timedif ;//pierwsza pozycja w pliku out to czas dzialania algorytmu[ms]
			for (int i = 0; i <N; i++)
			{
				output <<endl<< outputmatrix[i];//zapis do pliku   liczba liczba liczba (...)
			}
			output.close();
			delete[]outputmatrix;//usunięcie matrycy danych wyjsciowych
			return 0;
		}
		else
		{
			cerr << "error: output file corrupted";//blad w otwrciu pliku 2
			return -2;
		}
	}
	else
	{
		cerr << "error: input file corrupted";//blad w otwrciu pliku 1
		return -1;
	}
}

void Sort(int Input[], int Output[], int size)//algorytm sortujacy.
{
	short int * HelpMatrix = new short int[highest + 1];//matryca pomocznicza 

	for (int i = 0; i <= highest; i++)//inicjalizacja matrycy "0"
	{
		HelpMatrix[i] = 0;
	}
	for (int i = 0; i < size; i++)
	{
		HelpMatrix[(Input[i])]++;
	}
	for (int i = 1; i <= highest; i++)
	{
		HelpMatrix[i] += HelpMatrix[i - 1];
	}
	for (int i = size - 1; i >= 0; i--)
	{
		Output[(HelpMatrix[(Input[i])]) - 1] = Input[i]; 
		HelpMatrix[(Input[i])]--; // zmniejszenie indexu
	}
	delete[] HelpMatrix;
}
	
	

