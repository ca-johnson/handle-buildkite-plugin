# Taskkill Buildkite Plugin

A Buildkite plugin that allows running sysinternals handle64.exe prior to checkout, to ensure no files in the checkout directory are locked.

Requires handle64 in the PATH.

# Example

```yaml
steps:
  plugins:
    - ca-johnson/taskkill:
        processes: MyApp.exe,BuildTool.exe
```
