@echo off
setlocal EnableDelayedExpansion
SET GTK_CSD=1
SET GTK_THEME=Adwaita:dark
"%~dp0\launch-local-julia.bat" "%~dp0\misc\launch-ahorn.jl" %*