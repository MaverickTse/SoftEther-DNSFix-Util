function Get-PrimaryAdapter
{
    $adapter = Get-NetRoute | Where-Object -FilterScript {$_.NextHop -Ne "::"} | Where-Object -FilterScript { $_.NextHop -Ne "0.0.0.0" } | Where-Object -FilterScript { ($_.NextHop.SubString(0,6) -Ne "fe80::") } | Get-NetAdapter
    $primary_adapter = $adapter | Sort-Object -Property {$_.Name.length} | Select -ExpandProperty Name -First 1
    return $primary_adapter
}

$adp = Get-PrimaryAdapter
Write-Output $adp
