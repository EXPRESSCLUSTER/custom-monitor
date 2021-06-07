# Set teaming member NIC name
$memberName = "team"

# Please do NOT edit from here
$currentTime = Get-Date -Format "yyyy/MM/dd HH:mm:ss.fff"
Write-Output ($currentTime + " Monitor start.")
Write-Output ("Target mebmber: " + $memberName)
$result = Get-NetLbfoTeamMember -Name $memberName
if($result.OperationalStatus -ne "Active"){
    Write-Output ("Error! " + $result.FailureReason)
    $currentTime = Get-Date -Format "yyyy/MM/dd HH:mm:ss.fff"
    Write-Output ($currentTime + " Monitor failed: " + $result.FailureReason)
    $message = "NIC " + $memberName + " monitor failed: " + $result.FailureReason
    clplogcmd -l WARN -m $message
    exit 1
}
$currentTime = Get-Date -Format "yyyy/MM/dd HH:mm:ss.fff"
Write-Output ($currentTime + " Monitor succeeded.")
exit 0
