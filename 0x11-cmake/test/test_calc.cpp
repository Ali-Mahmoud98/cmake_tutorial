#include <catch2/catch_test_macros.hpp>
#include "calculator.h"

TEST_CASE("CalculatorTest - Add", "[Calculator]") {
    Calculator calc;
    REQUIRE(calc.add(2, 3) == 5);
    REQUIRE(calc.add(-2, 3) == 1);
    REQUIRE(calc.add(0, 0) == 0);
}

TEST_CASE("CalculatorTest - Sub", "[Calculator]") {
    Calculator calc;
    REQUIRE(calc.subtract(5, 3) == 2);
    REQUIRE(calc.subtract(3, 5) == -2);
    REQUIRE(calc.subtract(0, 0) == 0);
}

TEST_CASE("CalculatorTest - Mul", "[Calculator]") {
    Calculator calc;
    REQUIRE(calc.multiply(2, 3) == 6);
    REQUIRE(calc.multiply(-2, 3) == -6);
    REQUIRE(calc.multiply(0, 5) == 0);
}

TEST_CASE("CalculatorTest - Div", "[Calculator]") {
    Calculator calc;
    REQUIRE(calc.divide(6, 3) == 2);
    // REQUIRE(calc.divide(5, 2) == 2);
    REQUIRE(calc.divide(5, 2) == 2.5);
}
