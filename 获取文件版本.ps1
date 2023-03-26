# v1.0 ����Զ���ȡϵͳ�汾�����ݼ�����������豸

# Ҫ��ȡ��Ŀ¼
$BosPath = "C:\Office","C:\Positive","C:\Retalix","C:\WinSCP"
$FuelPath = "C:\Office","C:\Positive"
$PosPath = "C:\Positive","C:\Retalix"

# ��ȡϵͳ�汾���������
$OSVersion = (Get-WmiObject Win32_OperatingSystem).Caption
$HostName = (Get-WMIObject Win32_ComputerSystem).Name
$FileDate = Get-Date -Format "yyyy-MM-dd HH.mm.ss"

# �жϼ������
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

# �ж�ϵͳ�汾
if ($OSVersion -like "*Windows 7*")
{
    # Windows 7 ��ȡ�ļ��汾д���ļ�
    SystemInfo > $HostName" File Version "$FileDate".txt"
    foreach ($path in $CheckPath) {
        tree $path >> $HostName" File Version "$FileDate".txt"
        (Get-ChildItem -Path $path -Include *.exe,*.dll -Recurse) >> $HostName" File Version "$FileDate".txt"
    }
}else {
    # Windows 10 ��ȡ�ļ��汾д���ļ�
    Get-ComputerInfo > $HostName" File Version "$FileDate".txt"
    foreach ($path in $CheckPath) {
        tree $path >> $HostName" File Version "$FileDate".txt"
        (Get-ChildItem -Path $path -Include *.exe,*.dll -Recurse).VersionInfo >> $HostName" File Version "$FileDate".txt"
    }
}