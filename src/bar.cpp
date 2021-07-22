#include "odr/bar.hpp"

#include <iostream>

#define ADOBE_ODR_ENABLE_FIELD() 1

#include "odr/object.hpp"

void bar(object o) {
    o.print_field();
    std::cout << "from bar: " << o._field << '\n';
}
