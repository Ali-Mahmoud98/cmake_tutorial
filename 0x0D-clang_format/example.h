#ifndef EXAMPLE_H
#define EXAMPLE_H

#include <string>
#include <vector>

// A simple class that demonstrates usage of C++11 features
class Example {
public:
    // Constructor that initializes the name
    Example(const std::string& name);

    // Getter for the name
    std::string getName() const;

    // Adds an element to the list
    void addElement(int element);

    // Displays all elements in the list
    void displayElements() const;

private:
    std::string name;
    std::vector<int> elements;
};

#endif // EXAMPLE_H
