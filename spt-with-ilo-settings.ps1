
### NOTE: Not a fully functional script!!!
### Use it as example

# -------------- Attributes for ServerProfileTemplate "OX-Apollo-Storage-SPT"
$name                               = "5.30-OX-Apollo-Storage-SPT"
$shtName                            = "XL450 Gen10 1"
$sht                                = Get-OVServerHardwareType -Name $shtName
# -------------- Connections section
# -------------- Attributes for boot order settings
$bootOrder                          = ""
# -------------- Attributes for BIOS settings
$biosSettings                       = @(
	@{id = 'WorkloadProfile'; value = 'Custom'},
	@{id = 'ProcTurbo'; value = 'Disabled'},
	@{id = 'AdvancedMemProtection'; value = 'FastFaultTolerantADDDC'},
	@{id = 'EmbNicEnable'; value = 'Disabled'},
	@{id = 'MemPatrolScrubbing'; value = 'Disabled'},
	@{id = 'Dhcpv4'; value = 'Disabled'},
	@{id = 'InternalSDCardSlot'; value = 'Disabled'},
	@{id = 'NetworkBootRetry'; value = 'Disabled'}
)

# ---------- iLO User: gms
$user1userName                      = "gms"
$user1displayName                   = "GMS HPE Support"
$user1Password                      = Read-Host -Prompt "user1 password" -AsSecureString
$user1userConfigPriv                = $True
$user1remoteConsolePriv             = $True
$user1virtualMediaPriv              = $True
$user1virtualPowerAndResetPriv      = $True
$user1iLOConfigPriv                 = $True
$user1loginPriv                     = $True
$user1hostBIOSConfigPriv            = $True
$user1hostNICConfigPriv             = $True
$user1hostStorageConfigPriv         = $True
$user1                              = New-OVIloLocalUserAccount -Username $user1userName -Password $user1Password -DisplayName $user1displayName -AdministerUserAccounts $user1userConfigPriv -RemoteConsole $user1remoteConsolePriv -VirtualMedia $user1virtualMediaPriv -VirtualPowerAndReset $user1virtualPowerAndResetPriv -ConfigureIloSettings $user1iLOConfigPriv -Login $user1loginPriv -HostBIOS $user1hostBIOSConfigPriv -HostNIC $user1hostNICConfigPriv -HostStorage $user1hostStorageConfigPriv
# ---------- iLO User: automation
$user2userName                      = "automation"
$user2displayName                   = "HPE Automation Account"
$user2Password                      = Read-Host -Prompt "user2 password" -AsSecureString
$user2remoteConsolePriv             = $True
$user2virtualMediaPriv              = $True
$user2virtualPowerAndResetPriv      = $True
$user2iLOConfigPriv                 = $True
$user2loginPriv                     = $True
$user2hostBIOSConfigPriv            = $True
$user2hostNICConfigPriv             = $True
$user2hostStorageConfigPriv         = $True
$user2                              = New-OVIloLocalUserAccount -Username $user2userName -Password $user2Password -DisplayName $user2displayName -RemoteConsole $user2remoteConsolePriv -VirtualMedia $user2virtualMediaPriv -VirtualPowerAndReset $user2virtualPowerAndResetPriv -ConfigureIloSettings $user2iLOConfigPriv -Login $user2loginPriv -HostBIOS $user2hostBIOSConfigPriv -HostNIC $user2hostNICConfigPriv -HostStorage $user2hostStorageConfigPriv
$mpLocalAccounts                    = $user1, $user2
# ------------------- iLO Attribute: Key Manager
$kmPrimaryServerAddress             = "10.114.224.241"
$kmPrimaryServerPort                = 9006
$kmSecondaryServerAddress           = "10.114.226.14"
$kmSecondaryServerPort              = 9006
$kmRedundancyRequired               = $True
$kmGroupName                        = "HPAAS_Group"
$kmCertificateName                  = "Enterprise-Certification-Authority-05-G2.cer"
$kmLoginName                        = "HPAAS_KMIP"
$kmPassword                         = Read-Host -Prompt "iLO Object password" -AsSecureString

# ------------------- iLO Settings Policy
$iloSettings                        = New-OVServerProfileIloPolicy -ManageLocalAccounts -LocalAccounts $mpLocalAccounts -ManageKeyManager -PrimaryKeyServerAddress $kmPrimaryServerAddress -PrimaryKeyServerPort $kmPrimaryServerPort -SecondaryKeyServerAddress $kmSecondaryServerAddress -SecondaryKeyServerPort $kmSecondaryServerPort -RedundancyRequired $kmRedundancyRequired -KeymanagerGroupName $kmGroupName -KeymanagerLocalCertificateName $kmCertificateName -KeymanagerLoginName $kmLoginName -KeymanagerPassword $kmPassword


New-OVServerProfileTemplate -Name $name -ServerHardwareType $sht -ManageConnections $False  -Bios -BiosSettings $biosSettings -ManageIloSettings $True -IloSettingsConsistencyChecking $mpConsistency -IloSettings $iloSettings

