# Structure of the aliases files

Creating an alias for a specific configuration to abbreviate it, while retaining the same options as the original configuration.

## Basic Structure:

```nix
{
  config,
  options,
  lib,
  ...
}: {
    options = {
        "An Alias" = lib.mkOption {
            type = options."A Configuration".type.functor.wrapped; # Or lib.types.`type`
            default = {}; # The defaults are empty on purpose
            description = "A description";
        };
    };

    config = {
        "A Configuration" = lib.mkAliasDefinitions options."An Alias";
    };
}
```
