
CLS

$x = invoke-restmethod -uri  <<API Endpoint>>

if($x.check -ne 1) {

[System.Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$pwd = ConvertTo-SecureString "<<Key>>" -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ("SMTP_Injection", $pwd)
 
Send-MailMessage -From <<email>> -To <<EMAIL ADDRESS>> -Subject "ACN ISSUE" -Body "There is currently a connection issue with one of the servers. Please attend to this issue at your earliest convenience." `
 -SmtpServer smtp.sparkpostmail.com -Port 587 -Credential $creds -UseSsl


}else {
$date = get-date

# Create new PSobject for array values to properties
            $track = New-Object PSobject -Property @{
                'Time' = $date
                'executionTime' = $x.executionTime
                'Check' = $x.check
                } 


$track | Select-Object -property 'Time', 'Execution Time', 'Check' | export-csv -path .\checkTracker.csv

 
}


