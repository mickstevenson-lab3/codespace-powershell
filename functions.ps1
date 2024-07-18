function Get-ArtifactoryAsset {
  <#
  .SYNOPSIS 
  Download asset from artifactory.
  .DESCRIPTION
  Download asset from artifactory.
  Creates download directory if it does not exist.
  .PARAMETER ArtifactoryUrl
  Artifactory URL
  .PARAMETER ArtifactoryAssetPath
  Artifactory asset path
  .PARAMETER ArtifactoryUsername
  Artifactory username
  .PARAMETER ArtifactoryApiKey
  Artifactory API key
  .PARAMETER DownloadDirectory
  Download directory
#>
  param (
    [string]$ArtifactoryUrl,
    [string]$ArtifactoryAssetPath,
    [string]$ArtifactoryUsername,
    [string]$ArtifactoryApiKey,
    [string]$DownloadDirectory
  )

  try {
    $artifactoryFileUrl = "$ArtifactoryUrl/$ArtifactoryAssetPath"
    $localFilePath = "$DownloadDirectory/$(Split-Path -Leaf $ArtifactoryAssetPath)"
    
    New-Item -ItemType Directory -Force -Path $DownloadDirectory | Out-Null

    $headers = @{
      Authorization = "Basic " + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("${artifactoryUsername}:${artifactoryApiKey}"))
    }
    
    Invoke-RestMethod -Uri $artifactoryFileUrl -Headers $headers -OutFile $localFilePath
  }
  catch {
    HandleError
  }
}

function Publish-BlobStorageAsset {
  <#
  .SYNOPSIS 
  Publish blob storage asset.
  Authentication via OAuth (Microsoft Entra ID).
  Authenticate Azure DevOps Pipeline with call to function: AuthenticateServiceConnection
  ###
  .DESCRIPTION
  Publish blob storage asset.
  .PARAMETER StorageAccountName
  Storage account name
  .PARAMETER ContainerName
  Container name
  .PARAMETER BlobName
  Blob name
  .PARAMETER LocalAssetFilePath
  Local asset file path
#>
  param (
    [string]$StorageAccountName,
    [string]$ContainerName,
    [string]$BlobName,
    [string]$LocalAssetFilePath
  )
  try {
    $context = New-AzStorageContext -StorageAccountName $StorageAccountName
    Set-AzStorageBlobContent -File $LocalAssetFilePath -Container $ContainerName -Blob $BlobName -Context $context
  }
  catch {
    HandleError
  }
}

function DockerLogin {
  <#
  .SYNOPSIS 
  Login to docker container registry.
  .DESCRIPTION
  Login to docker container registry.
  Password retrieved from environment variable $env:DOCKERPASSWORD and passed to docker login via --password-stdin
  .PARAMETER DockerLogin
  Docker username
  .PARAMETER Server 
  Docker container registry server URL
#>
  param (
    [string]$DockerLogin,
    [string]$Server
  )
  try {
    $env:DOCKERPASSWORD | docker login --username $DockerLogin --password-stdin $Server
  }
  catch {
    HandleError
  }
}

function DockerLogout {
  <#
    .SYNOPSIS 
    Logout of docker container registry.
    .DESCRIPTION
    Logout of docker container registry.
    .PARAMETER Server 
    Docker container registry server URL
  #>
  param (
    [string]$Server
  )
  try {
    docker logout $Server
  }
  catch {
    HandleError
  }
}

function DockerBuild {
  <#
  .SYNOPSIS 
  Build docker container.
  .DESCRIPTION
  Build docker container.
  .PARAMETER ImageTag
  Docker image tage
  .PARAMETER BuildPath 
  Build path
#>
  param (
    [string]$ImageTag,
    [string]$BuildPath
  )
  try {
    docker build --tag $ImageTag $BuildPath
  }
  catch {
    HandleError
  }
}

function DockerPush {
  <#
  .SYNOPSIS 
  Push image to docker container registry.
  .DESCRIPTION
  Push image to docker container registry.
  .PARAMETER ImageTag
  Docker image tage
#>
  param (
    [string]$ImageTag
  )
  try {
    docker push $ImageTag
  }
  catch {
    HandleError
  }
}

function AuthenticateServiceConnection {
  <#
  .SYNOPSIS 
  Authenticate service connection.
  .DESCRIPTION
  Authenticate service connection.
#>
  Install-Module Az.Accounts -Force
  $credential = New-Object System.Management.Automation.PSCredential ("${env:SPID}", (ConvertTo-SecureString ${env:SPKEY} -AsPlainText -Force))
  Connect-AzAccount -Credential $Credential -Tenant ${env:TID} -ServicePrincipal
}

function HandleError {
  <#
  .SYNOPSIS 
  Common error handler.
  .DESCRIPTION
  Common error handler.
#>
  Write-host -f red "Encountered Error:"$_.Exception.Message
  Write-host $Error[0]
}
