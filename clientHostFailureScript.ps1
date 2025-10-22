function Get-AzVmStatus
{
    $payload
    $failure = $false
    $resourcegroupname = "NAC-K2A-23_RESOURCES"
    $nameList = ("client-k2a-14", "client-k2a-15", "client-k2a-16", "client-k2a-17")
    foreach ($name in $nameList)
    {
        
        $status = Get-AzVm -name $name -ResourceGroupName $resourcegroupname -status
        
        if (($status.Statuses[1].DisplayStatus -ne "VM running") -and $failure -eq $false)
        {
            $failure = $true
            $payload = @{
            VMName = $name
            Failed = $failure
            Information = $status.Statuses[1].DisplayStatus
        }
        $payload | ConvertTo-Json
           
           
            
            
        }
        
        
    }

    return $payload
}
Get-AzVmStatus