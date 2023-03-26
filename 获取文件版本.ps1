# v1.0 添加自动获取系统版本，根据计算机名区分设备

# 要获取的目录
$BosPath = "C:\Office","C:\Positive","C:\Retalix","C:\WinSCP"
$FuelPath = "C:\Office","C:\Positive"
$PosPath = "C:\Positive","C:\Retalix"

# 获取系统版本及计算机名
$OSVersion = (Get-WmiObject Win32_OperatingSystem).Caption
$HostName = (Get-WMIObject Win32_ComputerSystem).Name
$FileDate = Get-Date -Format "yyyy-MM-dd HH.mm.ss"

# 判断计算机名
if ($HostName -like "*BOS")
{
    $CheckPath = $BosPath
}
if ($HostName -like "*FUEL")
{
    $CheckPath = $FuelPath
}
if ($HostName -like "*POS")
{
    $CheckPath = $PosPath
}

# 判断系统版本
if ($OSVersion -like "*Windows 7*")
{
    # Windows 7 获取文件版本写入文件
    SystemInfo > $HostName" File Version "$FileDate".txt"
    foreach ($path in $CheckPath) {
        tree $path >> $HostName" File Version "$FileDate".txt"
        (Get-ChildItem -Path $path -Include *.exe,*.dll -Recurse) >> $HostName" File Version "$FileDate".txt"
    }
}else {
    # Windows 10 获取文件版本写入文件
    Get-ComputerInfo > $HostName" File Version "$FileDate".txt"
    foreach ($path in $CheckPath) {
        tree $path >> $HostName" File Version "$FileDate".txt"
        (Get-ChildItem -Path $path -Include *.exe,*.dll -Recurse).VersionInfo >> $HostName" File Version "$FileDate".txt"
    }
}