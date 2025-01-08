#include <iostream>
#include <concepts> // c++ 20

template<typename T>
requires std::integral<T>
T add(T a, T b) {
    return a + b;
}

int main() {
    std::cout << "Hello from c++ 20 with cmake on Linux/Windows" << std::endl;
    std::cout << "The sum of 1 and 2 is " << add(1, 2) << std::endl;
    return 0;
}
