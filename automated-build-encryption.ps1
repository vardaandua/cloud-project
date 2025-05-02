$fullImage = "docker.io/$($args[3]):$($args[2])"
$img_name_tag = "$($args[1]):$($args[2])"
$app_folder = "$($args[0])"
$pvt_key_path = "$($args[4])" 

Write-Host "                        Building image without cache from the appfolder"
docker build --no-cache -t $img_name_tag $app_folder

Write-Host "                        Tagging image with repostiory path"
docker tag $img_name_tag $fullImage
echo $fullImage

Write-Host "                        Pushing to Docker Hub"
docker push $fullImage

$pvt_key_path = "cosign.key"
Write-Host "                        Signing the image just pushed"
cosign sign --key  $pvt_key_path $fullImage





# param (
#     [string]$appFolder - 0 ,
#     [string]$imageName - 1,
#     [string]$tag - 2 ,
#     [string]$registryRepo "vardawndua/node-demo-app" -3,
#     [string]$keyPath "cosign.key" - 4
# ) 


# Write-Host "                        Installing Cosign"
# Invoke-WebRequest -Uri "https://github.com/sigstore/cosign/releases/latest/download/cosign-windows-amd64.exe" -OutFile "$env:USERPROFILE\cosign.exe" 
# $env:PATH += ";$env:USERPROFILE"

# Write-Host "                        Generating Public and Private keys"
# .\cosign.exe generate-key-pair

# .\automated-build-encryption.ps1 ".\node-demo-app" "node-demo-app" "latest" "vardawndua/node-demo-app" "cosign.key"
