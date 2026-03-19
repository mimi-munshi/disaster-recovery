

try {
   
    Connect-AzAccount -ErrorAction Stop

  
    $context = Get-AzContext
    Write-Host "Connected to subscription: $($context.Subscription.Name)" -ForegroundColor Green

    
    $events = Get-AzServiceHealthEvent -Status Active -ErrorAction Stop

    if ($events.Count -eq 0) {
        Write-Host  "No Azure service incidents." -ForegroundColor Green
    }
    else {
        Write-Host " Active Azure service incidents detected" -ForegroundColor Yellow
        $events | Format-Table Title, ImpactedServices, Status, StartTime

      
    }
}
catch {
    Write-Host " Error: $($_.Exception.Message)" -ForegroundColor Red
}
