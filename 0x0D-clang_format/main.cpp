#include <iostream>
#include "example.h"

int main() {
    // Create an Example object
    Example ex("MyExample");

    // Add some elements to the list
    ex.addElement(10);
    ex.addElement(20);
    ex.addElement(30);

    // Display the elements in the list
    ex.displayElements();

    // Print the name
    std::cout << "Example name: " << ex.getName() << std::endl;

    return 0;
}
