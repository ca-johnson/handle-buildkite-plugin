# Handle Buildkite Plugin

A Buildkite plugin that allows running sysinternals handle.exe prior to checkout, to ensure no files are locked.

Requires handle64 in the PATH.

# Example

```yaml
steps:
  plugins:
    - ca-johnson/handle:
        processes: MyApp.exe,BuildTool.exe
```
