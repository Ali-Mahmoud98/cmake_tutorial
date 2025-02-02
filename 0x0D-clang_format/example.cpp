#include "example.h"
#include <iostream>

// Constructor implementation
Example::Example(const std::string& name) : name(name) {
}

// Getter for name
std::string Example::getName() const {
    return name;
}

// Adds an element to the list
void Example::addElement(int element) {
    elements.push_back(element);
}

// Displays all elements in the list
void Example::displayElements() const {
    std::cout << "Elements in " << name << ":\n";
    for(const auto& elem : elements) {
        std::cout << elem << " ";
    }
    std::cout << std::endl;
}
