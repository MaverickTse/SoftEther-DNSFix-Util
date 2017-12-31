﻿; Generated by AutoGUI 2.1.5a
#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%
Gui MainWnd: New, +Labelmain_window +hWndhMain
Gui Add, Edit, hWndhPath vmgr_path x152 y35 w245 h21, C:\Program Files\SoftEther VPN Client\vpncmgr_x64.exe
Gui Add, Text, x17 y35 w130 h21 +0x200, Path to vpncmgr_x64.exe
Gui Add, Button, gOnSelectFile x404 y33 w80 h23, &Open
Gui Add, Text, x18 y73 w120 h23 +0x200, VPN Profile Order
Gui Add, Edit, hWndhOrder x152 y73 w104 h21 +Number
Gui Add, UpDown, hWndhUpDown gOnChangeOrder vorder Range2-99 x254 y73 w18 h21, 3
Gui Add, Button, hWndhStart gOnStartStop vbuttonlabel x95 y122 w304 h23, &Starts SoftEther VPN
IniRead, ipath, selauncher.ini, SETTINGS, ClientPath, C:\Program Files\SoftEther VPN Client\vpncmgr_x64.exe
IniRead, iorder, selauncher.ini, SETTINGS, VPNProfileOrder, 3
mgr_path := ipath
order := iorder
Gui Show, w516 h193, SoftEther Lancher with DNS-leak fix
Return

main_windowEscape:
main_windowClose:
    ExitApp

; Do not edit above this line
Running := false

OnSelectFile()
{
    FileSelectFile, filepath, 3, C:\Program Files\SoftEther VPN Client\vpncmgr_x64.exe, Select the SoftEther Client Executable, vpncmgr_x64 (*.exe)
    if (filepath)
    {
        GuiControl, , mgr_path, %filepath%
		IniWrite, %filepath%, selauncher.ini, SETTINGS, ClientPath
    }
    return filepath
}
OnChangeOrder()
{
    GuiControlGet, order
    IniWrite, %order%, selauncher.ini, SETTINGS, VPNProfileOrder
}
OnStartStop()
{
    global Running
    if (Running)
    {
        GuiControlGet, mgr_path
        GuiControlGet, order
        Running := !Running
		GuiControl,, buttonlabel, &Starts SoftEther VPN
        Run %mgr_path%
        Sleep, 500
        downrepeat := order -1
        SendInput {Home}
        SendInput {Down %downrepeat%}
        SendInput <^D
        Sleep, 300
        psRestoreDNS =
        (
            function Get-PrimaryAdapter
            {
                $adapter = Get-NetRoute | Where-Object -FilterScript {$_.NextHop -Ne '::'} | Where-Object -FilterScript { $_.NextHop -Ne '0.0.0.0' } | Where-Object -FilterScript { ($_.NextHop.SubString(0,6) -Ne 'fe80::') } | Get-NetAdapter
                $primary_adapter = $adapter | Sort-Object -Property {$_.Name.length} | Select -ExpandProperty Name -First 1
                return $primary_adapter
            }

            $adpter = Get-PrimaryAdapter
            Set-DnsClientServerAddress -InterfaceAlias $adpter -ResetServerAddresses
            Clear-DnsClientCache
        )
        Run *RunAs PowerShell.exe -Command &{%psRestoreDNS%},, hide
    }
    else
    {
        GuiControlGet, mgr_path
        GuiControlGet, order
        Running := !Running
		GuiControl,, buttonlabel, &Stops VPN
        Run %mgr_path%
        Sleep, 2000
        downrepeat := order -1
        SendInput {Home}
        SendInput {Down %downrepeat%}
        SendInput {Enter}
        Sleep 2000

        psFixDNS = 
        (
            function Get-PrimaryAdapter
            {
                $adapter = Get-NetRoute | Where-Object -FilterScript {$_.NextHop -Ne '::'} | Where-Object -FilterScript { $_.NextHop -Ne '0.0.0.0' } | Where-Object -FilterScript { ($_.NextHop.SubString(0,6) -Ne 'fe80::') } | Get-NetAdapter
                $primary_adapter = $adapter | Sort-Object -Property {$_.Name.length} | Select -ExpandProperty Name -First 1
                return $primary_adapter
            }

            $adpter = Get-PrimaryAdapter
            Set-DnsClientServerAddress -InterfaceAlias $adpter -ServerAddresses ('10.211.254.254')
            Clear-DnsClientCache
        )
        Run *RunAs PowerShell.exe -Command &{%psFixDNS%},, hide
    }
}

