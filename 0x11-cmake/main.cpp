#include <iostream>

#include "calculator.h"

int main () {
    Calculator calc;
    std::cout << "add(10,4): " << calc.add(10,4) << std::endl;
    std::cout << "sub(10,4): " << calc.subtract(10,4) << std::endl;
    std::cout << "mul(10,4): " << calc.multiply(10,4) << std::endl;
    std::cout << "div(10,4): " << calc.divide(10,4) << std::endl;
    return 0;
}
