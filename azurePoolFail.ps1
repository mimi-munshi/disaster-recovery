# Connect to Azure
Connect-AzAccount

# Set your subscription
Set-AzContext -SubscriptionId "<Your-Subscription-ID>"

# Variables
$resourceGroup = "<Your-Resource-Group>"
$hostPoolName  = "<Your-Host-Pool-Name>"

# Get session hosts in the host pool
$sessionHosts = Get-AzWvdSessionHost `
    -ResourceGroupName $resourceGroup `
    -HostPoolName $hostPoolName

# Check for unhealthy or unavailable hosts
$failedHosts = $sessionHosts | Where-Object {
    $_.Status -ne "Available" -or $_.AllowNewSession -eq $false
}

if ($failedHosts) {
    Write-Host "⚠ Host pool issues detected!" -ForegroundColor Yellow
    $failedHosts | ForEach-Object {
        Write-Host "Host: $($_.Name) | Status: $($_.Status) | AllowNewSession: $($_.AllowNewSession)" -ForegroundColor Red
    }
} else {
    Write-Host " All hosts are healthy and accepting sessions." -ForegroundColor Green
}
