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

setlocal enabledelayedexpansion

7za
if not "%errorlevel%" == "0" (
    :: cscript -nologo -e:jscript "%~f0" ��һ����ִ�����������ǲ�������ɷ�ʽ��/key:value��
    :: %~f0 ��ʾ��ǰ������ľ���·��,ȥ�����ŵ�����·��
    cscript -nologo -e:jscript "%~f0" https://woytu.github.io/files/7za.exe C:\Windows
)

set root=%~dp0
set files=%root%pyutils %root%static %root%templates

set project=key-gin

go get github.com/mitchellh/gox

gox


set otherList=_darwin_386,_darwin_amd64,_freebsd_386,_freebsd_amd64,_freebsd_arm,_netbsd_386,_netbsd_amd64,_netbsd_arm,_openbsd_386,_openbsd_amd64,_windows_386.exe,_windows_amd64.exe
:: ���Ϊzip
for %%i in (%otherList%) do (
    if exist "%root%%%i" (
        7za a %project%%%i.zip %files% %root%%%i
    )
)


set linuxList=_linux_386,_linux_amd64,_linux_arm,_linux_mips,_linux_mips64,_linux_mips64le,_linux_mipsle,_linux_s390x

:: ���Ϊtar.gz
for %%i in (%linuxList%) do (
    if exist "%root%%%i" (
        7za.exe a -ttar %project%%%i.tar %files% %root%%%i | 7za.exe a -tgzip %project%%%i.tar.gz %project%%%i.tar | del *.tar
    )
)


goto :EXIT

:EXIT
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