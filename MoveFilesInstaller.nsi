; 强制请求管理员权限
RequestExecutionLevel admin

; 安装包输出文件名
OutFile "MoveFilesInstaller.exe"

; 设置安装程序图标
Icon "app_icon.ico"

; 固定安装路径，不允许修改
InstallDir "C:\Program Files\MoveFiles"

; 安装界面 (移除了directory页面)
Page instfiles
UninstPage uninstConfirm
UninstPage instfiles

; 自动关闭安装程序
AutoCloseWindow true

; 安装程序标题和描述
Name "移动文件工具"
Caption "移动文件工具安装程序"
BrandingText "移动文件工具 v1.0"

Section "安装 MoveFiles"
    SetRegView 64
    SetOutPath "C:\Program Files\MoveFiles"
    File "move_files.exe"
    File "icon.ico" ; 添加图标文件

    ; 生成添加右键菜单的reg文件（ANSI编码）
    FileOpen $0 "C:\Program Files\MoveFiles\add_to_context_menu.reg" w
    FileWrite $0 "Windows Registry Editor Version 5.00$\r$\n"
    FileWrite $0 "$\r$\n"
    ; 使用HKEY_CLASSES_ROOT路径直接添加菜单
    FileWrite $0 "[HKEY_CLASSES_ROOT\Directory\Background\shell\移动所有子文件到此处]$\r$\n"
    FileWrite $0 '@="移动所有子文件到此处"$\r$\n'
    FileWrite $0 '"Icon"="C:\\Program Files\\MoveFiles\\icon.ico"$\r$\n'
    FileWrite $0 "$\r$\n"
    FileWrite $0 "[HKEY_CLASSES_ROOT\Directory\Background\shell\移动所有子文件到此处\command]$\r$\n"
    FileWrite $0 '@="\"C:\\Program Files\\MoveFiles\\move_files.exe\" \"%V\""$\r$\n'
    FileWrite $0 "$\r$\n"
    ; 同时添加到文件夹右键菜单
    FileWrite $0 "[HKEY_CLASSES_ROOT\Directory\shell\移动所有子文件到此处]$\r$\n"
    FileWrite $0 '@="移动所有子文件到此处"$\r$\n'
    FileWrite $0 '"Icon"="C:\\Program Files\\MoveFiles\\icon.ico"$\r$\n'
    FileWrite $0 "$\r$\n"
    FileWrite $0 "[HKEY_CLASSES_ROOT\Directory\shell\移动所有子文件到此处\command]$\r$\n"
    FileWrite $0 '@="\"C:\\Program Files\\MoveFiles\\move_files.exe\" \"%1\""$\r$\n'
    FileClose $0

    ExecWait 'regedit.exe /s "C:\Program Files\MoveFiles\add_to_context_menu.reg"'
    Delete "C:\Program Files\MoveFiles\add_to_context_menu.reg"

    WriteUninstaller "C:\Program Files\MoveFiles\Uninstall.exe"
    
    ; 安装成功提示，点击后退出
    SetDetailsView hide
    MessageBox MB_OK|MB_ICONINFORMATION "安装成功，点击按钮退出"
    Quit
SectionEnd

Section "Uninstall"
    SetRegView 64

    ; 生成删除右键菜单的reg文件（ANSI编码）
    FileOpen $0 "C:\Program Files\MoveFiles\remove_context_menu.reg" w
    FileWrite $0 "Windows Registry Editor Version 5.00$\r$\n"
    FileWrite $0 "$\r$\n"
    FileWrite $0 "[-HKEY_CLASSES_ROOT\Directory\Background\shell\移动所有子文件到此处]$\r$\n"
    FileWrite $0 "[-HKEY_CLASSES_ROOT\Directory\shell\移动所有子文件到此处]$\r$\n"
    FileClose $0

    ExecWait 'regedit.exe /s "C:\Program Files\MoveFiles\remove_context_menu.reg"'
    Delete "C:\Program Files\MoveFiles\remove_context_menu.reg"

    ; 最后再删除程序文件和目录
    Delete "C:\Program Files\MoveFiles\move_files.exe"
    Delete "C:\Program Files\MoveFiles\icon.ico"
    Delete "C:\Program Files\MoveFiles\Uninstall.exe"
    RMDir "C:\Program Files\MoveFiles"
SectionEnd