$endpoint = "https://www.breakingbadapi.com/api/1"
Invoke-restmethod -Uri $endpoint

# get-help Invoke-restmethod 
#  Invoke-RestMethod [-Uri] <uri> [-Method {Default | Get | Head | Post | Put | Delete | Trace | Options | Merge | Patch}] [-UseBasicParsing] 
# [# -WebSession <WebRequestSession>] [-SessionVariable <string>] [-Credential <pscredential>] [-UseDefaultCredentials]
# [-CertificateThumbprint <string>] [-Certificate <X509Certificate>] [-UserAgent <string>] [-DisableKeepAlive]
# [-TimeoutSec <int>] [-Headers <IDictionary>] [-MaximumRedirection <int>] 
# [-Proxy <uri>] [-ProxyCredential <pscredential>] [-ProxyUseDefaultCredentials] 
# [-Body <Object>] [-ContentType <string>] [-TransferEncoding {chunked | compress | deflate | gzip | identity}] [-InFile <string>] [-OutFile <string>] [-PassThru]  [<CommonParameters>]
