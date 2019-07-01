powershell -ExecutionPolicy Bypass -NoProfile -NonInteractive %~dp0/purge.ps1 -Dir "%BUILDKITE_BUILD_CHECKOUT_PATH%" -Whitelist "%BUILDKITE_PLUGIN_TASKKILL_WHITELIST%"
