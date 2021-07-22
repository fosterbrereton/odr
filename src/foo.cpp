#include "odr/foo.hpp"

#include <iostream>

#define ADOBE_ODR_ENABLE_FIELD() 0

#include "odr/object.hpp"

void foo(object o) {
    o.print_field();
    std::cout << "from foo: " << o._field << '\n';
}
