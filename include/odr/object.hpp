#include <cstdint>

struct base {
    virtual void print_field() = 0;
};

struct object : public base {
#if ADOBE_ODR_ENABLE_FIELD()
    std::uint64_t _optional{0xdeadbeef};
#endif

    std::uint32_t _field{0xad0be000};

    void print_field() override {
        std::cout << "field: " << _field << '\n';
    }
};
