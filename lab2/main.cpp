#include <iostream>

int main() {
	signed char nums[] = {-1, 2, -3, 4, -5, 6, -7, 16, -9};

	for (int i = 0; i < 9; i++) {
		if (nums[i] < 0) {
			nums[i] <<= 2;
		}
		else {
			nums[i] &= ~(1 << 0);
			nums[i] &= ~(1 << 4);
		}
		
		std::cout << +nums[i] << std::endl;
	}

	return 0;
}
