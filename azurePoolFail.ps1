
Connect-AzAccount


Set-AzContext -SubscriptionId "<Subscription-ID>"

$resourceGroup = "<Resource-Group>"
$hostPoolName  = "<Host-Pool-Name>"

$sessionHosts = Get-AzWvdSessionHost `
    -ResourceGroupName $resourceGroup `
    -HostPoolName $hostPoolName

$failedHosts = $sessionHosts | Where-Object {
    $_.Status -ne "Available" -or $_.AllowNewSession -eq $false
}

if ($failedHosts) {
    Write-Host "Host pool issues detected" -ForegroundColor Yellow
    $failedHosts | ForEach-Object {
        Write-Host "Host: $($_.Name) | Status: $($_.Status) | AllowNewSession: $($_.AllowNewSession)" -ForegroundColor Red
    }
} else {
    Write-Host " All hosts successful." -ForegroundColor Green
}
