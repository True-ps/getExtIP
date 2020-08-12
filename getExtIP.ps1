

$logFileExists = [System.Diagnostics.EventLog]::SourceExists("EXTIP");
#if the log source exists, it uses it. if it doesn't, it creates it.
if (! $logFileExists)
{New-EventLog -LogName Application -Source "EXTIP"} 
#writes events to the windows event log
$path2IP = "C:\Ip"
$IP = (Invoke-WebRequest -uri "http://ifconfig.me/ip" -UseBasicParsing).Content
    if ((Test-Path $path2IP)-eq $false)
        {
        $IP > $path2IP        
        Write-EventLog -LogName Application -Source "EXTIP" -EntryType Error -EventID 818 -Message ("Your IP file was missing. We just created it. Your Public IP address is:`n$IP ")
        }
    else
        {
            $getIP = gc $path2IP
            if ($getIP -ne $IP)
                {
                    Write-EventLog -LogName Application -Source "EXTIP" -EntryType Warning -EventID 817 -Message ("Your IP record was updated!`nBefore, it was $getIP`n`nYour new IP is $ip ")
                    $loadIP = $IP > $path2IP
                }
            else
                {
                    Write-EventLog -LogName Application -Source "EXTIP" -EntryType Information -EventID 816 -Message ("Your public IP is $getip")
                }
            }
            
   



