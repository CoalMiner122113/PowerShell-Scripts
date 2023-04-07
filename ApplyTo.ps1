param(
	[Parameter(Mandatory=$true)]
	[string]$name,
	[Parameter(Mandatory=$false)]
	[int]$num = 1,
	[Parameter(Mandatory=$false)]
	[bool]$ML = $false,
	[Parameter(Mandatory=$false)]
	[bool]$resumePdf = $false
)

Write-Host "Script Running..."

#Get the path
$initPath = "$env:userprofile\OneDrive\Documents\Class Spring 23\Resumes"
$finalPath = $initPath + "\" + $name

#Make The Directory
mkdir $finalPath

#Copy Resume as pdf into folder if desired
if($resumePdf){
	$dest = $finalPath+"\Resume.pdf"
	Copy-Item -Path "$env:userprofile\OneDrive\Documents\Class Spring 23\Functional Resume.pdf" -Destination $dest
}
#Else copy resume as docx to edit
else{
	$dest = $finalPath+"\Resume.docx"
	Copy-Item -Path "$env:userprofile\OneDrive\Documents\Class Spring 23\Functional Resume.docx" -Destination $dest
	Start-Process $dest
}


#Copy Cover letter into folder and open the file
$dest = $finalPath+"\CoverLetter.docx"

#If ML is true, use ML cover letter
if($ML){
	Copy-Item -Path "$env:userprofile\OneDrive\Documents\Class Spring 23\ML Cover Letter.docx" -Destination $dest

}
else{
	Copy-Item -Path "$env:userprofile\OneDrive\Documents\Class Spring 23\Cover Letter Template.docx" -Destination $dest
}
Start-Process $dest

#Make text file to copy job description into
$dest = $finalPath + "\jobDesc.txt"
New-Item -ItemType File -Path $dest
Start-Process $dest
