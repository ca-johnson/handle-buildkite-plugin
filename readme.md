# Taskkill Buildkite Plugin

A Buildkite plugin that allows running sysinternals handle64.exe prior to checkout, to ensure no files in the checkout directory are locked.

Requires handle64 in the PATH.

Unless a whitelist is specified, kills all processes.

## Examples

Kills all processes in BUILDKITE_BUILD_CHECKOUT_PATH

```yaml
steps:
  plugins:
    # https://github.com/ca-johnson/taskkill-buildkite-plugin
    - ca-johnson/taskkill: ~
```

Kills all processes in BUILDKITE_BUILD_CHECKOUT_PATH but not `notepad.exe` and `explorer.exe`

```yaml
steps:
  plugins:
    # https://github.com/ca-johnson/taskkill-buildkite-plugin
    - ca-johnson/taskkill:
        whitelist: notepad.exe,explorer.exe
```
