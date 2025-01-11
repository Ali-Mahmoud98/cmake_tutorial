#include <iostream>
#include "operations.h"
#include "dog.h"
#include "log.h"

int main(){
    auto val = ((10 <=> 20) > 0); // "<=>" called the three way comparison operator, c++20

    double result = add(2,70);
    std::cout << "result : " << result << std::endl;

    Dog dog("Flitzy");
    dog.print_info();

   log_data("Hello there",LogType::FATAL_ERROR);

    return 0;
}