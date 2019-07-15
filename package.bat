1>1/* :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  bajins 1.0.0  by bajins https://batch.bajins.com
:: �׷�����µ�ַ:https://batch.bajins.com
::
:: ʹ��ʱ�뽫bajins.bat��������һ��PATH�е�Ŀ¼�Ա����
:: ����ȷ��bajins.batӵ�и�Ŀ¼�Ķ�дȨ��(�����ò�Ҫѡ��system32)
:: �����½�һ��Ŀ¼ר��bajins.batʹ��,�ٽ����Ŀ¼��ӵ�PATH��

@echo off
md "%~dp0$testAdmin$" 2>nul
if not exist "%~dp0$testAdmin$" (
    echo bajins���߱�����Ŀ¼��д��Ȩ��! >&2
    exit /b 1
) else rd "%~dp0$testAdmin$"

:: �����ӳٻ���������չ
setlocal enabledelayedexpansion

7za
:: ���7zѹ�������в����ڣ�������
if not "%errorlevel%" == "0" (
    :: cscript -nologo -e:jscript "%~f0" ��һ����ִ�����������ǲ�������ɷ�ʽ��/key:value��
    :: %~f0 ��ʾ��ǰ������ľ���·��,ȥ�����ŵ�����·��
    cscript -nologo -e:jscript "%~f0" https://woytu.github.io/files/7za.exe C:\Windows
)
:: ��Ҫ������ļ����ļ��и�Ŀ¼
set root=%~dp0
:: ��Ҫ������ļ����ļ���
set files=%root%pyutils %root%static %root%templates
:: �����ɵ��ļ�����ǰһ����
set project=key-gin
:: �����ɵ��ļ�������һ���֣���ǰһ���ֽ������
set allList=_darwin_386,_darwin_amd64,_freebsd_386,_freebsd_amd64,_freebsd_arm,_netbsd_386,_netbsd_amd64,_netbsd_arm,_openbsd_386,_openbsd_amd64,_windows_386.exe,_windows_amd64.exe,_linux_386,_linux_amd64,_linux_arm,_linux_mips,_linux_mips64,_linux_mips64le,_linux_mipsle,_linux_s390x

for %%i in (%allList%) do (
    :: ����������ļ������������´��
    if not exist "%root%%project%%%i" (
        go get github.com/mitchellh/gox
        gox
        :: ɾ���ɵ�ѹ�����ļ�
        del *.zip *.tar *.gz
    )
)


set otherList=_darwin_386,_darwin_amd64,_freebsd_386,_freebsd_amd64,_freebsd_arm,_netbsd_386,_netbsd_amd64,_netbsd_arm,_openbsd_386,_openbsd_amd64,_windows_386.exe,_windows_amd64.exe
:: ���Ϊzip
for %%i in (%otherList%) do (
    set runFile=%root%%project%%%i
    :: !!��%%��һ������˼��ȡ������ֵ�������ַ������������ļ�ǰ��һ���� setlocal EnableDelayedExpansion���ӳٻ���������չ�� ���
    if exist "!runFile!" (
        :: ��7zѹ���ļ�Ϊzip
        7za a %project%%%i.zip %files% !runFile!
        :: ɾ���������ļ�
        del !runFile!
    )
)


set linuxList=_linux_386,_linux_amd64,_linux_arm,_linux_mips,_linux_mips64,_linux_mips64le,_linux_mipsle,_linux_s390x

:: ���Ϊtar.gz
for %%i in (%linuxList%) do (
    set runFile=%root%%project%%%i
    if exist "!runFile!" (
        :: ��7zѹ����tar
        7za a -ttar %project%%%i.tar %files% !runFile!
        :: ��7z��tarѹ����gz
        7za a -tgzip %project%%%i.tar.gz %project%%%i.tar
        :: ɾ��tar�ļ��Ͷ������ļ�
        del *.tar !runFile!
    )
)


goto :EXIT

:EXIT
:: �����ӳٻ���������չ������ִ��
endlocal&exit /b %errorlevel%
*/

// ****************************  JavaScript  *******************************


var iRemote = WScript.Arguments(0);
iRemote = iRemote.toLowerCase();
var iLocal = WScript.Arguments(1);
iLocal = iLocal.toLowerCase()+"\\"+ iRemote.substring(iRemote.lastIndexOf("/") + 1);
var xPost = new ActiveXObject("Microsoft.XMLHTTP");
xPost.Open("GET", iRemote, 0);
xPost.Send();
var sGet = new ActiveXObject("ADODB.Stream");
sGet.Mode = 3;
sGet.Type = 1;
sGet.Open();
sGet.Write(xPost.responseBody);
sGet.SaveToFile(iLocal, 2);
sGet.Close();