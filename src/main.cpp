#include <iostream>

#define ADOBE_ODR_ENABLE_FIELD() 1

#include "odr/object.hpp"
#include "odr/foo.hpp"
#include "odr/bar.hpp"

int main(int argc, const char * argv[]) {
#if defined(__has_feature)
    #if __has_feature(address_sanitizer)
        std::cout << "ASan: enabled\n";
    #else
        std::cout << "ASan: disabled\n";
    #endif
#else
    std::cout << "ASan: unknown\n";
#endif

    object o;

    o._field = 42;

    foo(o);
    bar(o);

    return 0;
}
