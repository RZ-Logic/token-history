@echo off
REM Daily token-history collection for Windows (Task Scheduler entry point).
REM Windows counterpart of scripts/install-launchd.sh. Adapted from
REM ericbclim/token-history. Runs the collector, which snapshots ccusage output
REM into data/<host>/<date>.json, commits and pushes; GitHub Actions then
REM re-renders the charts and badges.
setlocal
set "REPO=%~dp0.."
set "PY=%REPO%\.venv\Scripts\python.exe"
REM Task Scheduler starts with a minimal PATH: add node (for npx/ccusage) and git.
set "PATH=C:\Program Files\nodejs;C:\Program Files\Git\cmd;%REPO%\.venv\Scripts;%PATH%"
set "GIT_TERMINAL_PROMPT=0"

cd /d "%REPO%" || exit /b 1
echo. >> "%REPO%\collect.log"
echo ==== %DATE% %TIME% ==== >> "%REPO%\collect.log"
"%PY%" scripts\collect.py >> "%REPO%\collect.log" 2>&1
exit /b %ERRORLEVEL%
