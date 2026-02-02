# Ensure Az module is installed
# Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force

try {
    # Connect to Azure
    Connect-AzAccount -ErrorAction Stop

    # Get current subscription context
    $context = Get-AzContext
    Write-Host "Connected to subscription: $($context.Subscription.Name)" -ForegroundColor Green

    # Retrieve active service health events (similar to Azure Status page)
    $events = Get-AzServiceHealthEvent -Status Active -ErrorAction Stop

    if ($events.Count -eq 0) {
        Write-Host "✅ No active Azure service incidents." -ForegroundColor Green
    }
    else {
        Write-Host "⚠ Active Azure service incidents detected!" -ForegroundColor Yellow
        $events | Format-Table Title, ImpactedServices, Status, StartTime

        # Example: Send email alert (requires configured SMTP relay)
        $smtpServer = "smtp.yourserver.com"
        $from = "azure-alerts@yourdomain.com"
        $to = "admin@yourdomain.com"
        $subject = "Azure Service Health Alert"
        $body = "Active Azure incidents detected:`n" + ($events | Out-String)

        Send-MailMessage -SmtpServer $smtpServer -From $from -To $to -Subject $subject -Body $body
    }
}
catch {
    Write-Host " Error: $($_.Exception.Message)" -ForegroundColor Red
}
