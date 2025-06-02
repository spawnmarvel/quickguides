
# output all SPN's for user
setspn -l f_username | Out-File -FilePath c:\kerb\bck_spn.txt

# get ms allow delegation

$(get-aduser f_username -property msDS-AllowedToDelegateTo)."msDS-AllowedtoDelegateTo” | Sort-Object