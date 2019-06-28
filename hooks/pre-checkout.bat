powershell -ExecutionPolicy Bypass -NoProfile -NonInteractive %~dp0/purge.ps1 -Dir "%BUILDKITE_BUILD_CHECKOUT_PATH%" %BUILDKITE_PLUGIN_TASKKILL_PROCESSES% 
