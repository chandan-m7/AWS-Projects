Import-Module AWS.Tools.S3

$region = Read-Host -Prompt 'enter the region'

$bucketName = Read-Host -Prompt 'S3 Bucket Name'

Write-Host "S3 Bucket: $bucketName"
Write-Host "AWS Region: $region"

function BucketExists {
    $bucket = Get-S3Bucket -BucketName $bucketName -ErrorAction SilentlyContinue
    return $null -ne $bucket
}

if (-not (BucketExists)){
    Write-Host " Bucket doesnot Exists......"
    # create a new bucket
    New-S3Bucket -BucketName $bucketName -Region $region   
} 
else{
    Write-Host "Bucket already exists...."
}


# Create new file
$filename = Read-Host -Prompt 'enter file name'
$filecontent = Read-Host -Prompt 'enter file content'
Set-Content -Path $filename -Value $filecontent

Write-S3Object -BucketName $bucketName -File $filename -Key $fileName