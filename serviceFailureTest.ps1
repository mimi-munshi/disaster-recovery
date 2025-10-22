function Test-ServiceStatus
{
    
    $serviceList = ("NetLogon", "Workstation", "Server")
    
      $failedServices = [System.Collections.ArrayList]::new()

    foreach ($service in $serviceList)
    {
        if((Get-Service -DisplayName $service).Status -ne 'Running')
        {
           
           $failedServices.Add($service)

        }
    }
$payload = @{
    FailedServices = $failedServices
}
    return $payload
    

}
<#function Send-ServiceStatus
{
    $results = Test-ServiceStatus
    $list = $payload.FailedServices
    foreach($item in $list)
    {
        
    }
    
}#>