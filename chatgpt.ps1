param(
	[Parameter(Mandatory=$true)]
	[string]$prompt,
	[Parameter(Mandatory=$false)]
	[string]$model = 'davinci-codex',
	[Parameter(Mandatory=$false)]
	[int]$max_tokens = 100
 
)

Write-Host "Script Running..."

# Set your API key as an environment variable - Not loading onto github!
#$env:OPENAIKEY = !!!

# Set the API endpoint
if($model -eq 'davinci-codex'){
	$endpoint = 'https://api.openai.com/v1/engines/davinci-codex/completions'
}
else{
	Write-Host "Invalid model type, valid model types are:\ndavinci-codex\n"
}

# Import the Invoke-RestMethod cmdlet
Import-Module Microsoft.PowerShell.Utility

# Set the parameters for the API request
    
$payload = @{
	prompt      = $prompt
      temperature = 0
      max_tokens  = $maxTokens
      stop        = "###"
	stream	= $true
}

$irmParams = @{
      Uri         = $endpoint 
      Method      = 'Post' 
      ContentType = 'application/json'
      Headers     = @{Authorization = "Bearer $($env:OPENAIKEY)" } 
      Body        = $payload | ConvertTo-Json
}

# Send the API request and parse the response
$response = Invoke-RestMethod @irmParams

#$generated_text = $response.choices.text iff stream -eq false, else : 

$generated_text = @($response)
for ($i=0; $i -lt $generated_text.length; $i++){
	$temp = ($generated_text[$i])
	#convert to json, take .data.choices.text???S
	#$temp = $($temp.choices.text)
	Write-Host "$temp"
}




