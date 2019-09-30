$EmailFrom = "chris@digitallycultured.com"
$EmailTo = "chris@digitallycultured.com"
$Subject = "FileZilla transfer is complete"
$Body = "Your most recent FileZilla transfer has completed."
 
$SMTPServer = "smtp.office365.com"
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
$SMTPClient.EnableSsl = $true
 
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("chris@digitallycultured.com", "dYwTEf6EzSgzAz3R");
 
$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)