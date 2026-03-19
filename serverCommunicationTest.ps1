
$servers = @("NAC-Mtech-23", "NAC-HV21", "AzFS-19","PD-Print-2002","NAC-K2A-23","NAC-AD21","NAC-AD0")

foreach ($server in $servers) {
    try {
        
        $result = Test-Connection -ComputerName $server -Count 2 -ErrorAction Stop

        Write-Host " $server is reachable." 
    }
    catch {
        Write-Host "$server is NOT reachable." -ForegroundColor Red
    }
}
