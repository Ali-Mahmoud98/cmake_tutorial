#include <iostream>
#include "stats.h"

int main() {
    int a = 10, b = 20;

    std::cout << "Mean: " << stats::mean(a, b) << std::endl;
    std::cout << "Difference: " << stats::difference(a, b) << std::endl;

    return 0;
}
