#include <iostream>
#include <fstream>
#include <random>

extern "C" void FUNC(int* array, int array_size, int* left_borders, int intervals_size, int* result, int* sum_array);

int main()
{

    setlocale(0, "");

    int array_size;

    std::cout << "Введите число генерируемых чисел: ";

    std::cin >> array_size;

    int xMin, xMax;

    std::cout << "Введите минимальное значение: ";

    std::cin >> xMin;

    std::cout << "Введите максимальное значение: ";

    std::cin >> xMax;

    if (xMax < xMin)
    {

        std::cout << "Неверно введены максимальное и минимальное значения";

        return 0;
    }

    int intervals_size;

    std::cout << "Введите количество интервалов: ";

    std::cin >> intervals_size;

    if (intervals_size <= 0 || intervals_size > 24)
    {

        std::cout << "Неверно введено количество интервалов";

        return 0;
    }

    if (intervals_size >= std::abs(xMax - xMin))
    {

        std::cout << "Неверно введено количество интервалов.\nКоличество интервалов должно быть меньше длины диапозона возможных значений.";

        return 0;
    }

    int* left_borders = new int[intervals_size];

    std::cout << "Введите левые границы: ";

    for (int i = 0; i < intervals_size; i++)

        std::cin >> left_borders[i];

    for (int i = 0; i < intervals_size - 1; i++)
    {

        for (int j = i + 1; j < intervals_size; j++)
        {

            if (left_borders[j] < left_borders[i])
            {

                std::swap(left_borders[j], left_borders[i]);
            }
        }
    }

    if (intervals_size > 0 && left_borders[0] < xMin)
    {

        std::cout << "Некоторые левые границы интервалов меньше минимального возомжного значения";

        return 0;
    }

    std::random_device rd;

    std::mt19937 gen(rd());

    std::normal_distribution<> dis((xMin + xMax) / 2, std::abs(xMax - xMin) / 4);

    int* array = new int[array_size];

    for (int i = 0; i < array_size; i++)
        array[i] = std::round(dis(gen));

    std::ofstream file("out.txt");

    file << "Сгенерированные числа: ";

    for (int i = 0; i < array_size; i++)
        file << array[i] << ' ';

    file << '\n';

    std::cout << "Сгенерированные числа: ";

    for (int i = 0; i < array_size; i++)
        std::cout << array[i] << ' ';

    std::cout << '\n';

    int* result = new int[intervals_size];
    int* sum_array = new int[intervals_size];

    for (int i = 0; i < intervals_size; i++)
    {
        result[i] = 0;
        sum_array[i] = 0;
    }
        

    FUNC(array, array_size, left_borders, intervals_size, result, sum_array);

    std::cout << "Номер интервала \tЛевая граница интервала \tКоличество чисел в интервале \tАбсолютная сумма чисел в интервале" << '\n';

    file << "Номер интервала \tЛевая граница интервала \tКоличество чисел в интервале \tАбсолютная сумма чисел в интервале" << '\n';

    for (int i = 0; i < intervals_size; i++)
    {

        std::cout << "\t" << i + 1 << "\t\t\t" << left_borders[i] << "\t\t\t" << result[i] << "\t\t\t\t\t\t" << sum_array[i]<< '\n';

        file << "\t" << i + 1 << "\t\t\t" << left_borders[i] << "\t\t\t" << result[i] << "\t\t\t\t\t\t" << sum_array[i] << '\n';
    }

    file.close();

    system("pause");

    return 0;
}
