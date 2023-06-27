#If you have the Choco package management module installed in Windows, you can find the PowerCLI module in the repository:
#choco search vmware and install it:

choco install vmware-powercli-psmodule

#The PowerCLI module is not available in winget yet.

#To import the PowerCLI module to the current PowerShell ISE or Visual Studio Code session, run the following command:

Import-Module VMware.VimAutomation.Core

Get-Command –Module *vmware*

#Get Commands in PowerCLI Core
#To disable VMware Customer Experience Improvement Program (CEIP) notification:

Set-PowerCLIConfiguration -Scope AllUsers -ParticipateInCeip $false

#To connect to vCenter Server or an ESXi host:

Connect-VIServer <vCenter_or_ESXi_FQDN>

I#f you are using a self-signed SSL certificate for your vCenter Server, PowerCLI will block the connection:
#Connect-VIServer Error: Invalid server certificate. Use Set-PowerCLIConfiguration to set the value for the InvalidCertificateAction option to Prompt if you'd like to connect once or to add a permanent exception for this server.
#Additional Information: Could not establish trust relationship for the SSL/TLS secure channel with authority.
#To ignore self-signed certificates:

Set-PowerCLIConfiguration -Scope AllUsers -InvalidCertificateAction Warn

#To display a list of virtual machines registered on your ESXi (or vCenter) server:

Get–VM

#To show powered off VMs only:

Get-VM | Where {$_.Powerstate -ne “PoweredOn”} | Select Name, VMHost, NumCPU, MemoryMB, Version|Format-Table

#To start a virtual machine:
Start-VM -VM MUNTestVM1
#To restart a VM correctly (using VMware tools agent):
Restart-VMGuest -VM MunTestVM1 -Confirm:$False
#To shut down a VM:
#Shutdown-VMGuest -VM MunTestVM1 -Confirm:$False
#To display a list of snapshots for a VM:
Get-VM -VM MunTestVM1 | Get-Snapshot| Format-List
#To move a running VM to another host using VMotion, the Move-VM command is used. For example, you want to move all VMs from mun-esxi1 to mun-esxi2:
#Get-VMHost mun-esxi1|Get-Vm| Move-VM –Destination (Get-VMHost mun-esxi2)
#To create a new virtual machine, use the New-VM cmdlet:
New-VM –Name MunTestVM1 -VMHost mun-esxi1 –ResourcePool Production –DiskGB 20 –DiskStorageFormat Thin –Datastore MUN_MSA2000_Prod1
#Use the Set-VM cmdlet in order to change virtual machine settings.
#Using PowerCLI cmdlets, you can interact with a guest operating system of your virtual machines. To do it, VMware Tools must be installed in the VM. You can update VMware Tools as shown below:
Get-VMGuest MunTestVM1 | Update-Tools
#Using Invoke-VMS, you can run a script or program in a guest Windows OS:
$script = '"%programfiles%\Common Files\Microsoft Shared\MSInfo\msinfo32.exe" /report "%tmp%\inforeport"'
Invoke-VMScript -ScriptText $script -VM MunTestVM1 -HostCredential $hostCred -GuestCredential $VMCred -ScriptType Bat

#To copy a file to all VMs, run this command:
Get-VM | Copy-VMGuestFile -Source C:\PS\get-size.ps1 -Destination C:\PS\ - LocalToGuest -GuestUser administrator -GuestPassword P@ssdr0w2

#The module contains cmdlets to manage clusters, datacenters, datastores, and ESXi hosts:

Get-VMHost
Get-Datacenter
Get-Cluster
Get-Datastore
Get-VirtualPortGroup