# Powershell PKI


## Create Your Own SSL Certificate using PowerShell

This is simple as it looks. Using the ‘New-SelfSignedCertificate’ cmdlet, you can create self-signed certificate in a jiffy.

```ps1
$Certificate=New-SelfSignedCertificate –Subject testing.com -CertStoreLocation Cert:\CurrentUser\My 
```

## Export Self-signed Certificate using PowerShell

```ps1
$Certificate=New-SelfSignedCertificate –Subject testing.com -CertStoreLocation Cert:\CurrentUser\My 

Export-Certificate -Cert $Certificate -FilePath "C:\$certname.cer" 

```

## Export Certificate with Private Key

```ps1
$Certificate=New-SelfSignedCertificate –Subject testing.com -CertStoreLocation Cert:\CurrentUser\My 

$Pwd = ConvertTo-SecureString -String "Testing" -Force -AsPlainText 
Export-PfxCertificate -Cert $Certificate -FilePath "D:\$certname.pfx" -Password $Pwd 


```

## Create Self-signed SSL Certificate with Longer Expiry


```ps1
# month
$Certificate=New-SelfSignedCertificate –Subject testing.com -CertStoreLocation Cert:\CurrentUser\My -NotAfter (Get-Date).AddMonths(36) 

# years

$Certificate=New-SelfSignedCertificate –Subject testing.com -CertStoreLocation Cert:\CurrentUser\My -NotAfter (Get-Date).AddYears(5) 

```


## Delete Self-Signed Certificate using PowerShell

```ps1
Remove-Item -Path Cert:\CurrentUser\My\{PasteTheCertificateThumbprintHere} -DeleteKey  

```