[cmdletbinding()]
Param(
    [Parameter(Manadatory=$true)]
    $thumbprint,
    [Parameter(Manadatory=$true)]
    $Connector,
    [Parameter(Manadatory=$true)]
    [ValidateSet("Receive","Send")]
    $ConnectorType
)

$TLSCert = Get-ExchangeCertificate -Thumbprint $thumbprint
$TLSCertName = "<I>$($TLSCert.Issuer)<S>$($TLSCert.Subject)"

if ($ConnectorType -eq "Receive")
{
    Set-ReceiveConnector -Identity $Connector -TlsCertificateName $null
    Set-ReceiveConnector -Identity $Connector -TlsCertificateName $TLSCertName
}

if ($ConnectorType -eq "Send")
{
    Set-SendConnector -Identity $Connector -TlsCertificateName $null
    Set-SendConnector -Identity $Connector -TlsCertificateName $TLSCertName
}