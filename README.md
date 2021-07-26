# Delete rows from a Sharepoint list

With this PowerShell script you can delete all rows from a Sharepoint list instead of deleting rows for each "page" from a list.

First you just have to define what is the website URL as this example: https://example.sharepoint.com/sites/BI

```shell
# Sharepoint website URL that will connect
$SiteURL = "https://test.sharepoint.com/sites/Test"
```

You also need to set the list name from your webiste


```shell
# List name that will get the list items
$ListName = "Your-List-Name"
```

Finally one you need to set your credentials that you use to connect in Sharepoint
```shell
# Password from your email to connect to Sharepoint
$Password = "Your user password"

# Email to connect to Sharepoint
$UserName = "Your user e-mail"
```
