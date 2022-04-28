While(1) {
    # First we create the request.
	#$HTTP_Request = [System.Net.WebRequest]::Create('https://youriis-site.com')

	# We then get a response from the site.
	#$HTTP_Response = $HTTP_Request.GetResponse()

	# We then get the HTTP code as an integer.
	#$HTTP_Status = [int]$HTTP_Response.StatusCode
	
	$response = try { 
       (Invoke-WebRequest -Uri 'http://nuget-az.selise.biz/nuget/Packages' -ErrorAction Stop).BaseResponse
	   	#then convert the status code enum to int by doing this
     } 
	catch [System.Net.WebException] 
	{ 
	   Write-Host "The Site may be down, please check!"
	   Write-Host "IIS Restarting"
	   iisreset
	   Write-Host "IIS Restarted"
       Write-Verbose "An exception was caught: $($_.Exception.Message)"
       $_.Exception.Response 
	  
    } 
	
    $HTTP_Status = [int]$response.BaseResponse.StatusCode
	If ($HTTP_Status -eq 200) {
		 Write-Host "Site is OK!"
	}

	
	# Finally, we clean up the http request by closing it.
   # If ($HTTP_Response -eq $null) { } 
   # Else { $HTTP_Response.Close() }
	Write-Host "This script will check status after 15 minutes"
	start-sleep -seconds 900
	
	
}
