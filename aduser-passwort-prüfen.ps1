#Mit Hilfe von PowerShell kann man sich recht einfach einen Überblick darüber verschaffen, welche User ihr Passwort nicht ändern müssen oder die gar keines benötigen. Das erste der beiden Anliegen kann man mit Hilfe von Get-ADUser erledigen:

Get-ADUser -Filter 'PasswordNeverExpires -eq $TRUE' -Properties PasswordNeverExpires

#Möchte man wissen, welche Konten kein Passwort benötigen, dann kann Search-ADAccount darauf keine Antwort geben, wohl aber Get-ADUser:

Get-ADUser -Filter 'PasswordNotRequired -eq $TRUE' | select Name

#Problematische Einstellungen zurücksetzen
#Möchte man die Risiken beseitigen, die mit diesen Einstellungen verbunden sind, dann kann PowerShell mit Set-ADUser die entsprechenden Attribute auch zurücksetzen:

Get-ADUser -Filter 'PasswordNeverExpires -eq $True' | Set-ADUser -PasswordNeverExpires $False

#In diesem Beispiel würde sämtlichen Konten in der Domäne, die bis dato kein Ablaufdatum für das Kennwort haben, ein solches wieder vorgeschrieben.


#Wann haben Benutzer zuletzt ihr Passwort im Active Directory geändert?

#Um das Datum des letzten Kennwort­wechsels für alle User in einer OU anzuzeigen, gibt man einen Befehl nach diesem Muster ein:

Get-ADUser -SearchBase "OU=Sales,DC=contoso,DC=de" -Filter * -properties PasswordLastSet | select Name, PasswordLastSet

#In unserem Beispiel möchte man aber wissen, wer nach einem bestimmten Datum sein Passwort noch nicht gewechselt hat. Diese Abfrage könnte so aussehen:

Get-ADUser -Properties PasswordLastSet -Filter "PasswordLastSet -gt '10/01/2022'" | select name, PasswordLastSet

#Diese Abfrage würde alle Accounts auflisten, die ihr Kennwort seit dem 1. Oktober 2022 noch nicht geändert haben.