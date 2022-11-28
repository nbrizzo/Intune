#Labtech Install

#Call installer from Intune app package

msiexec /i "Install.msi" /quiet /norestart SERVERADDRESS=<CWA Server URL> SERVERPASS=<Server Password> LOCATION=<location ID>
