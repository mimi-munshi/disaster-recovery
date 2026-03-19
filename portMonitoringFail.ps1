
$expectedPorts = @()
$currentPorts  = (Get-NetTCPConnection).LocalPort | Sort-Object -Unique

$missing = $expectedPorts | Where-Object { $_ -notin $currentPorts }

if ($missing) {
    Write-Warning "Missing expected listening ports: $($missing -join ', ')"
} else {
    Write-Host "All expected ports are active."
}
