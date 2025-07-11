@echo off
setlocal

REM 获取当前批处理所在目录
set "target_dir=%~dp0"

REM 复制 move_files.exe 到当前目录（如果已存在则覆盖）
copy /Y "%~dp0move_files.exe" "%target_dir%"

REM 导入注册表，注册右键菜单
reg import "%~dp0add_to_context_menu.reg"

echo 安装完成！右键文件夹即可使用“移动所有子文件到此处”功能。
pause 