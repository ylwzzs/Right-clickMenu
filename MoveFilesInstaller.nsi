; 强制请求管理员权限
RequestExecutionLevel admin

; 安装包输出文件名
OutFile "MoveFilesInstaller.exe"

; 默认安装路径
InstallDir "$PROGRAMFILES\MoveFiles"

; 安装界面
Page directory
Page instfiles
UninstPage uninstConfirm
UninstPage instfiles

Section "安装 MoveFiles"
    SetRegView 64
    SetOutPath "$INSTDIR"
    File "move_files.exe"

    ; 生成添加右键菜单的reg文件（ANSI编码）
    FileOpen $0 "$INSTDIR\add_to_context_menu.reg" w
    IntCmp $0 0 +2
        MessageBox MB_OK "reg 文件打开失败"
    FileWrite $0 "Windows Registry Editor Version 5.00$\r$\n"
    FileWrite $0 "$\r$\n"
    FileWrite $0 "[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\shell\移动所有子文件到此处]$\r$\n"
    FileWrite $0 '@="移动所有子文件到此处"$\r$\n'
    FileWrite $0 "$\r$\n"
    FileWrite $0 "[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\shell\移动所有子文件到此处\command]$\r$\n"
    FileWrite $0 '@="\"$INSTDIR\\move_files.exe\" \"%1\""$\r$\n'
    FileClose $0

    ExecWait 'regedit.exe /s "$INSTDIR\add_to_context_menu.reg"'
    Delete "$INSTDIR\add_to_context_menu.reg"

    WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd

Section "Uninstall"
    SetRegView 64

    ; 生成删除右键菜单的reg文件（ANSI编码）
    FileOpen $0 "$INSTDIR\remove_context_menu.reg" w
    IntCmp $0 0 +2
        MessageBox MB_OK "卸载时reg 文件打开失败"
    FileWrite $0 "Windows Registry Editor Version 5.00$\r$\n"
    FileWrite $0 "$\r$\n"
    FileWrite $0 "[-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\shell\移动所有子文件到此处]$\r$\n"
    FileClose $0

    ExecWait 'regedit.exe /s "$INSTDIR\remove_context_menu.reg"'
    Delete "$INSTDIR\remove_context_menu.reg"

    ; 最后再删除程序文件和目录
    Delete "$INSTDIR\move_files.exe"
    Delete "$INSTDIR\Uninstall.exe"
    RMDir "$INSTDIR"
SectionEnd