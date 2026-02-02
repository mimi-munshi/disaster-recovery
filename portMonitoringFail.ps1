$port = 443
$test = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue

if (-not $test) {
    Write-Warning "Port $port is NOT listening — possible monitoring failure."
} else {
    Write-Host "Port $port is active and listening."
}
$server = "myserver.domain.com"
$port   = 8080

if (-not (Test-NetConnection -ComputerName $server -Port $port).TcpTestSucceeded) {
    Write-Warning "Port $port on $server is unreachable — monitoring may have failed."
} else {
    Write-Host "Port $port on $server is reachable."
}
$expectedPorts = @(80, 443, 3389)
$currentPorts  = (Get-NetTCPConnection).LocalPort | Sort-Object -Unique

$missing = $expectedPorts | Where-Object { $_ -notin $currentPorts }

if ($missing) {
    Write-Warning "Missing expected listening ports: $($missing -join ', ')"
} else {
    Write-Host "All expected ports are active."
}
