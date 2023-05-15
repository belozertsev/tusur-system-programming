// Напишите программу, в которой создается двумерный числовой массив и для
// этого массива вычисляется сумма квадратов его элементов.

#include <iostream>

extern "C" {
	int solution(int **, int, int);
}

int main() {
	int rows;
	int cols;
	int N = 10; // 0 <= matrix[i][j] < N

	std::cout << "Введите кол-во строк матрицы: ";
	std::cin >> rows;
	std::cout << "Введите кол-во столбцов матрицы: ";
	std::cin >> cols;
	if (rows < 1 || cols < 1) {
		std::cout << "Кол-во строк/столбцов должно быть целым, положительным числом" << std::endl;
		return 1;
	}

	// Выделение памяти под матрицу
	int **matrix = (int **)malloc(rows * sizeof(int *));
	for (int i = 0; i < rows; i++) {
		matrix[i] = (int *)malloc(sizeof(int) * cols);
	}

	// Заполнение матрицы случайными числами и отображение её в консоль
	std::cout << "Матрица:" << std::endl;
	for (int i = 0; i < rows; i++) {
		for (int j = 0; j < cols; j++) {
			matrix[i][j] = rand() % N;
			std::cout << matrix[i][j] << " ";
		}
		std::cout << std::endl;
	};

	// Вычисление суммы квадратов элементов
	int S = solution(matrix, rows, cols);
	std::cout << std::endl;
	std::cout << "Sum of (element^2) = " << S << std::endl;

	return 0;
}
