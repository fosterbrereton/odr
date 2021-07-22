# odr

This application demonstrates a violation of C++'s One Definition Rule. It's primary purpose is as a testbed to grok clang's AddressSanitizer.

# Helpful Links

- https://clang.llvm.org/docs/AddressSanitizer.html
- https://github.com/google/sanitizers/wiki/AddressSanitizerFlags
- https://github.com/google/sanitizers/wiki/AddressSanitizerOneDefinitionRuleViolation

# Tips

1. Pass variables into `asan` by setting the env var `ASAN_OPTIONS`. Separate multiple values with a colon (`:`). Example:
 ```shell
 export ASAN_OPTIONS=detect_odr_violation=2:html_cov_report=true
 ```
1. To get AddressSanitizer's help page, set the following env var before running your asan-enabled app:

 ```shell
 export ASAN_OPTIONS=help=1
 ```

