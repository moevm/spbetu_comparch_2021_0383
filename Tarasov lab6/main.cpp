#include <iostream>
#include <fstream>
#include <random>
#include <time.h>

using namespace std;

extern "C" void first(int* numbers, int numbers_size, int* result, int xmin);
extern "C" void second(int* array, int array_size, int xmin, int* intervals, int intervals_size, int* result);


int main() {
	setlocale(0, "Russian");
	srand(time(NULL));
	ofstream result("result.txt");

	int numbers_size;
	int* numbers;
	int xmin, xmax;
	int intervals_size;
	int* intervals;
	int* intervals2;
	int* mod1_result;
	int* mod2_result;

	cout << "������� ���������� �����:\n";
	cin >> numbers_size;
	if (numbers_size > 16 * 1024) {
		cout << "���������� ����� ������ ���� ������ ��� �����, ��� 16*1024\n";
		return 0;
	}
	cout << "������� xmin � xmax:\n";
	cin >> xmin >> xmax;
	int Dx = xmax - xmin;
	if (Dx > 24) {
		cout << "Xmax � Xmin �� ����� ���������� ������ ��� �� 24\n";
		return 0;
	}

	cout << "������� ����� ������:\n";
	cin >> intervals_size;

	if (intervals_size > 24) {
		cout << "����� ���������� ������ ���� ������ ��� ����� 24\n";
		return 0;
	}
	if (intervals_size < Dx) {
		cout << "����� ���������� ������ ���� ������ ��� ����� Dx(Xmax-Xmin)\n";
		return 0;
	}
	numbers = new int[numbers_size];
	intervals = new int[intervals_size];
	intervals2 = new int[intervals_size];

	int len_asm_mod1_res = abs(xmax - xmin) + 1;
	mod1_result = new int[len_asm_mod1_res];
	for (int i = 0; i < len_asm_mod1_res; i++)
		mod1_result[i] = 0;


	mod2_result = new int[intervals_size + 1];
	for (int i = 0; i < intervals_size + 1; i++)
		mod2_result[i] = 0;


	cout << "������� ��� �������:\n";
	for (int i = 0; i < intervals_size; i++) {
		cin >> intervals[i];
		if (intervals[i] <= xmin) {
			cout << "����� ������� ������ ���� ������ Xmin\n";
			return 0;
		}
		intervals2[i] = intervals[i];
	}


	std::random_device rd;
	std::mt19937 gen(rd());
	std::uniform_int_distribution<> dis(xmin, xmax);
	for (int i = 0; i < numbers_size; i++) numbers[i] = dis(gen);


	cout << "��������������� ��������\n";
	result << "��������������� ��������\n";
	for (int i = 0; i < numbers_size; i++) {
		cout << numbers[i] << ' ';
		result << numbers[i] << ' ';
	}
	cout << '\n';
	cout << '\n';
	result << '\n';
	result << '\n';

	first(numbers, numbers_size, mod1_result, xmin);

	second(mod1_result, numbers_size, xmin, intervals, intervals_size, mod2_result);

	cout << "���������:\n";
	result << "���������:\n";
	cout << "�\t�������\t���������� �����" << endl;
	result << "�\t�������\t���������� �����" << endl;

	for (int i = 1; i < intervals_size + 1; i++) {
		if (i != intervals_size) {
			cout << i << "\t" << intervals2[i - 1] << '\t' << mod2_result[i] << endl;
			result << i << "\t" << intervals2[i - 1] << '\t' << mod2_result[i] << endl;
		}
		else {
			cout << i << "\t" << xmax << '\t' << mod2_result[i] << endl;
			result << i << "\t" << xmax << '\t' << mod2_result[i] << endl;
		}
	}

	delete[] numbers;
	delete[] intervals;
	delete[] intervals2;
	delete[] mod1_result;
	delete[] mod2_result;

	return 0;
}