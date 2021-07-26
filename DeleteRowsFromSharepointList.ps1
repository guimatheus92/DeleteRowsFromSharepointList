# -------------------------------------------------------------------------------------------'
# Title: Download all rows from a Sharepoint list
# Author: Guilherme Matheus
# Date: Script created on 05/07/2020
# Script and data info: This script can delete all rows from a Sharepoint list
# Documentation: https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/connect-pnponline?view=sharepoint-ps
#--------------------------------------------------------------------------------------------'

# Import the module from Sharepoint Online
Import-Module PnP.PowerShell

# Sharepoint website URL that will connect
# The URL can be something like https://example.sharepoint.com/sites/BI
$SiteURL = "https://test.sharepoint.com/sites/Test"

# List name that will get the list items
$ListName = "Your-List-Name"

# Email to connect to Sharepoint
$UserName = "Your user e-mail"

# Password from your email to connect to Sharepoint
$Password = "Your user password"

# Create a new object
$cc = New-Object Microsoft.SharePoint.Client.ClientContext($SiteURL)

# Connect on sharepoint list from the credentials above
$cc.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($UserName, (ConvertTo-SecureString $Password -AsPlainText -Force))

$list = $cc.Web.Lists.GetByTitle($ListName)
$query = New-Object Microsoft.SharePoint.Client.CamlQuery
$query.ViewXml = "<View><RowLimit>200</RowLimit></View>"

do
{
    $started = Get-Date
    $items = $list.GetItems($query)
    $cc.Load($items)
    $cc.ExecuteQuery()

    if ($items.Count -eq 0) { break }

    for ($i = 0; $i -lt $items.Count; $i++)
    {
        # Delete row 
        # Because DeleteObject() effectively change the collection the index 0 is not a mistake
        $items[0].DeleteObject()
    }

    $cc.ExecuteQuery()
    # Write in the console the process time elapsed
    Write-Host "Time elapsed: $((Get-Date) - $started)"
} while ($true)

# Disconnect from PnP module
Disconnect-PnPOnline