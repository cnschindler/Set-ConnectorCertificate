[cmdletbinding()]
Param(
    [Parameter(Mandatory=$true)]
    $thumbprint,
    [Parameter(Mandatory=$true)]
    $Connector,
    [Parameter(Mandatory=$true)]
    [ValidateSet("Receive","Send")]
    $ConnectorType
)

$TLSCert = Get-ExchangeCertificate -Thumbprint $thumbprint
$TLSCertName = "<I>$($TLSCert.Issuer)<S>$($TLSCert.Subject)"

if ($ConnectorType -eq "Receive")
{
    try
    {
        Set-ReceiveConnector -Identity $Connector -TlsCertificateName $null -ErrorAction Stop
        Write-Host -ForegroundColor Green -Object "Successfully removed value from property 'TLSCertificateName' on $($ConnectorType)-Connector $($Connector)"
    }

    catch
    {
        Write-Host -ForegroundColor Red -Object "Error removing value from property 'TLSCertificateName' on $($ConnectorType)-Connector $($Connector). Error: $($_)"
    }

    try
    {
        Set-ReceiveConnector -Identity $Connector -TlsCertificateName $TLSCertName -ErrorAction Stop
        Write-Host -ForegroundColor Green -Object "Successfully set the value of property 'TLSCertificateName' to $($TLSCertName) on $($ConnectorType)-Connector $($Connector)"
    }

    catch
    {
        Write-Host -ForegroundColor Red -Object "Error setting value $($TLSCertName) for property 'TLSCertificateName' on $($ConnectorType)-Connector $($Connector). Error: $($_)"        
    }
}

if ($ConnectorType -eq "Send")
{
    try
    {
        Set-SendConnector -Identity $Connector -TlsCertificateName $null -ErrorAction Stop
        Write-Host -ForegroundColor Green -Object "Successfully removed value from property 'TLSCertificateName' on $($ConnectorType)-Connector $($Connector)"
    }

    catch
    {
        Write-Host -ForegroundColor Red -Object "Error removing value from property 'TLSCertificateName' on $($ConnectorType)-Connector $($Connector). Error: $($_)"
    }

    try
    {
        Set-SendConnector -Identity $Connector -TlsCertificateName $TLSCertName -ErrorAction Stop
        Write-Host -ForegroundColor Green -Object "Successfully set the value of property 'TLSCertificateName' to $($TLSCertName) on $($ConnectorType)-Connector $($Connector)"
    }

    catch
    {
        Write-Host -ForegroundColor Red -Object "Error setting value $($TLSCertName) for property 'TLSCertificateName' on $($ConnectorType)-Connector $($Connector). Error: $($_)"        
    }
}