# verify-and-deploy.ps1
#  "docker.io/vardawndua/node-demo-app:latest"
# "default"
$imageName = $($args[0])
$namespace = $($args[1]) 


# Paths
$tempPubPath = "cosign_temp.pub"
$decodedKeyPath = "cosign.pub"

# Fetch the public key from Kubernetes secret and decode
Write-Output "Fetching public key from Kubernetes secret..."
$base64Key = kubectl get secret cosign-public-key -n $namespace -o jsonpath="{.data['cosign\.pub']}"

if (-not $base64Key) {
    Write-Error "Failed to retrieve key from secret 'cosign-public-key' in namespace '$namespace'."
    exit 1
}

# Write the base64-encoded key to a temp file
Set-Content -Path $tempPubPath -Value $base64Key -Encoding ASCII

# Decode it using certutil
certutil -decode $tempPubPath $decodedKeyPath | Out-Null

if (-not (Test-Path $decodedKeyPath)) {
    Write-Error "Failed to decode the public key."
    exit 1
}


# Run cosign verification
Write-Output "Verifying image signature using Cosign..."
&cosign verify --key $decodedKeyPath $imageName

if ($LASTEXITCODE -eq 0) {
    Write-Host "Signature Verified. Deploying..."
    kubectl apply -f deployment.yaml
    kubectl apply -f service.yaml
} else {
    Write-Host "Signature Verification FAILED. Not deploying."
}

# Clean up
Remove-Item $tempPubPath -ErrorAction SilentlyContinue
