#include <iostream>
#include "math_operations.h"
#include "string_operations.h"

int main() {
    int a = 10, b = 20;
    std::string text = "CMake Example";

    std::cout << "Addition of " << a << " and " << b << ": " << add(a, b) << std::endl;
    std::cout << "Concatenated String: " << concatenate(text, " Project") << std::endl;

    return 0;
}
