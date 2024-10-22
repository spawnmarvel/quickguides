$fqdn = "xxxx.servicebus.windows.net" 
$port = 443

$tcpsocket = New-Object Net.Sockets.TcpClient($fqdn, $port)
$tcpstream = $tcpsocket.GetStream()
$sslStream = New-Object Net.Security.SslStream($tcpstream, $false)
$sslStream.AuthenticateAsClient($fqdn)
$certinfo = New-Object security.cryptography.x509certificates.x509certificate2($sslStream.RemoteCertificate)