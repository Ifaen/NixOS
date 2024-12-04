### Structure of the aliases files

Making an Alias of certain Configuration, to abbreviate, using the same options it originally has

# Basic Structure:

```
{
    Options = {
        `Alias` = lib.mkOption {
            type = options.`Configuration`.type.functor.wrapped;
            default = {}; # The defaults are empty on purpose
            description = `A description`;
        };
    };

    config = {
        `Configuration` = lib.mkAliasDefinitions options.`Alias`;
    };
}
```
