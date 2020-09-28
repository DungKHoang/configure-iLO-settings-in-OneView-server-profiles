# Configure iLO settings in OneView server profiles

With the OneView PowerShell library release 5.4 , administrator can fully configure iLO settings through server profiles or templates instead of logging into the iLO to apply the needed settings.
iLO settings configured in server profiles/templates include:
   * local Administrator account 
   * iLO user account
   * LDAP Directory Server
   * LDAP Directory Group
   * Key Manager for Encryption

There are 3 new cmdlets related to iLO settings. They are
   * New-OVIloLocalUserAccount
   * New-OVIloDirectoryGroup
   * New-OVServerProfileIloPolicy
I refer you to the help file for addtional details on those cmdlets

spt-with-ilo-settings.ps1 is an example of PowerShell script that leverages new iLO cmdlets to configure iLO settings in server rpofile templates.
Use it as a reference to customize your script

Note: The script is generated using the Convertto-OVPowerShellscript cmdlet !

Enjoy!


## Prerequisites
   * OneView PowerShell library v5.4



