; ǿ���������ԱȨ��
RequestExecutionLevel admin

; ��װ������ļ���
OutFile "MoveFilesInstaller.exe"

; ���ð�װ����ͼ��
Icon "app_icon.ico"

; �̶���װ·�����������޸�
InstallDir "C:\Program Files\MoveFiles"

; ��װ���� (�Ƴ���directoryҳ��)
Page instfiles
UninstPage uninstConfirm
UninstPage instfiles

; �Զ��رհ�װ����
AutoCloseWindow true

; ��װ������������
Name "�ƶ��ļ�����"
Caption "�ƶ��ļ����߰�װ����"
BrandingText "�ƶ��ļ����� v1.0"

Section "��װ MoveFiles"
    SetRegView 64
    SetOutPath "C:\Program Files\MoveFiles"
    File "move_files.exe"
    File "icon.ico" ; ���ͼ���ļ�

    ; ��������Ҽ��˵���reg�ļ���ANSI���룩
    FileOpen $0 "C:\Program Files\MoveFiles\add_to_context_menu.reg" w
    FileWrite $0 "Windows Registry Editor Version 5.00$\r$\n"
    FileWrite $0 "$\r$\n"
    ; ʹ��HKEY_CLASSES_ROOT·��ֱ����Ӳ˵�
    FileWrite $0 "[HKEY_CLASSES_ROOT\Directory\Background\shell\�ƶ��������ļ����˴�]$\r$\n"
    FileWrite $0 '@="�ƶ��������ļ����˴�"$\r$\n'
    FileWrite $0 '"Icon"="C:\\Program Files\\MoveFiles\\icon.ico"$\r$\n'
    FileWrite $0 "$\r$\n"
    FileWrite $0 "[HKEY_CLASSES_ROOT\Directory\Background\shell\�ƶ��������ļ����˴�\command]$\r$\n"
    FileWrite $0 '@="\"C:\\Program Files\\MoveFiles\\move_files.exe\" \"%V\""$\r$\n'
    FileWrite $0 "$\r$\n"
    ; ͬʱ��ӵ��ļ����Ҽ��˵�
    FileWrite $0 "[HKEY_CLASSES_ROOT\Directory\shell\�ƶ��������ļ����˴�]$\r$\n"
    FileWrite $0 '@="�ƶ��������ļ����˴�"$\r$\n'
    FileWrite $0 '"Icon"="C:\\Program Files\\MoveFiles\\icon.ico"$\r$\n'
    FileWrite $0 "$\r$\n"
    FileWrite $0 "[HKEY_CLASSES_ROOT\Directory\shell\�ƶ��������ļ����˴�\command]$\r$\n"
    FileWrite $0 '@="\"C:\\Program Files\\MoveFiles\\move_files.exe\" \"%1\""$\r$\n'
    FileClose $0

    ExecWait 'regedit.exe /s "C:\Program Files\MoveFiles\add_to_context_menu.reg"'
    Delete "C:\Program Files\MoveFiles\add_to_context_menu.reg"

    WriteUninstaller "C:\Program Files\MoveFiles\Uninstall.exe"
    
    ; ��װ�ɹ���ʾ��������˳�
    SetDetailsView hide
    MessageBox MB_OK|MB_ICONINFORMATION "��װ�ɹ��������ť�˳�"
    Quit
SectionEnd

Section "Uninstall"
    SetRegView 64

    ; ����ɾ���Ҽ��˵���reg�ļ���ANSI���룩
    FileOpen $0 "C:\Program Files\MoveFiles\remove_context_menu.reg" w
    FileWrite $0 "Windows Registry Editor Version 5.00$\r$\n"
    FileWrite $0 "$\r$\n"
    FileWrite $0 "[-HKEY_CLASSES_ROOT\Directory\Background\shell\�ƶ��������ļ����˴�]$\r$\n"
    FileWrite $0 "[-HKEY_CLASSES_ROOT\Directory\shell\�ƶ��������ļ����˴�]$\r$\n"
    FileClose $0

    ExecWait 'regedit.exe /s "C:\Program Files\MoveFiles\remove_context_menu.reg"'
    Delete "C:\Program Files\MoveFiles\remove_context_menu.reg"

    ; �����ɾ�������ļ���Ŀ¼
    Delete "C:\Program Files\MoveFiles\move_files.exe"
    Delete "C:\Program Files\MoveFiles\icon.ico"
    Delete "C:\Program Files\MoveFiles\Uninstall.exe"
    RMDir "C:\Program Files\MoveFiles"
SectionEnd