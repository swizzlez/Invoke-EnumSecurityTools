function Invoke-EnumSecurityTools {

      <#
      .SYNOPSIS
        Enumerates any security tools running on the system.
        Author:  Chris Myers (@swizzlez_)

      .DESCRIPTION
        Grabs a list of services on the system and compares the service name to kown service
        names of security tools such as AV and EDR. Outputs a list of identified tools and
        their status. 
            
      .EXAMPLE
        PS>Import-Module .\Invoke-EnumSecurityTools.ps1
        PS>Invoke-EnumSecurityTools
            Enumerating Security Tools...

            Security_Tool                                Status
            -------------                                ------
            Windows Defender Network Inspection Service Stopped
            Windows Defender                            Running
      #>

    $av_list = @{
    "symantec antivirus"="Symantec Endpoint Protection"
    mcshield="McAfee Security"
    windefend="Windows Defender"
    msmpsvc="Microsoft Security Essentials"
    msmpeng="Microsoft Security Essentials"
    savservice="Sophos Antivirus"
    aveservice="Avast!"
    "avast! antivirus"="Avast!"
    immunetprotect="Immunet Protect"
    fsma="F-Secure"
    antivirservice="AntiVir"
    avguard="Avira"
    fpavserver="F-Protect"
    pshost="Panda Security"
    pavsrv="Panda AntiVirus"
    bdss="BitDefender"
    abmainsv="ArcaBit/ArcaVir"
    "ikarus-guardx"="IKARUS"
    ekrn="ESET Smart Security"
    avkproxy="G Data Antivirus"
    klblmain="Kaspersky Lab Antivirus"
    vbservprof="Symantec VirusBlast"
    clamav="ClamAV"
    EMET_Service="Microsoft EMET"
    Sense="Windows Defender Advanced Threat Protection Service"
    WdNisSvc="Windows Defender Network Inspection Service"
    "Parity Agent"="Bit 9 Parity Application Whitelisting"
    "csagent"="CrowdStrike Falcon EDR Agent"
    }


    Write-Output "Enumerating Security Tools..."
    $objParams = @{
        "Security_Tool"="Tool Name"
        "Status"="Status"
    }
    $toolObj = New-Object -TypeName PSObject -Property $objParams
    Get-Service | ForEach-Object { 
            if ($av_list.ContainsKey($_.Name)) { 
                $toolObj.Security_Tool = $av_list[$_.Name]
                $toolObj.Status = $_.Status 
                Write-Output $toolObj
            } 
        }
}
