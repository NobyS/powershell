#Mit Hilfe von PowerShell kann man sich recht einfach einen Überblick darüber verschaffen, welche User ihr Passwort nicht ändern müssen oder die gar keines benötigen. Das erste der beiden Anliegen kann man mit Hilfe von Get-ADUser erledigen:

Get-ADUser -Filter 'PasswordNeverExpires -eq $TRUE' -Properties PasswordNeverExpires

#Möchte man wissen, welche Konten kein Passwort benötigen, dann kann Search-ADAccount darauf keine Antwort geben, wohl aber Get-ADUser:

Get-ADUser -Filter 'PasswordNotRequired -eq $TRUE' | select Name

#Problematische Einstellungen zurücksetzen
#Möchte man die Risiken beseitigen, die mit diesen Einstellungen verbunden sind, dann kann PowerShell mit Set-ADUser die entsprechenden Attribute auch zurücksetzen:

Get-ADUser -Filter 'PasswordNeverExpires -eq $True' |
Set-ADUser -PasswordNeverExpires $False

#In diesem Beispiel würde sämtlichen Konten in der Domäne, die bis dato kein Ablaufdatum für das Kennwort haben, ein solches wieder vorgeschrieben.