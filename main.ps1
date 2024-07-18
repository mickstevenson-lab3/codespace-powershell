. ./functions.ps1

# Get-ArtifactoryAsset `
# -ArtifactoryUrl "https://contosotest.jfrog.io/artifactory" `
# -ArtifactoryAssetPath "a015c0_dbp-generic-local/assets/test.txt" `
# -ArtifactoryUsername "L190339" `
# -ArtifactoryApiKe "Password!@1234" `
# -DownloadDirectory "/tmp/Get-ArtifactoryAsset"

Publish-BlobStorageAsset `
-StorageAccountName "psuploadtst" `
-ContainerName "upload" `
-BlobName "test.txt" `
-LocalAssetFilePath "/tmp/Get-ArtifactoryAsset/test.txt"

# $DockerServer = 'contosotest.jfrog.io'
# $DockerImageTag = 'contosotest.jfrog.io/docker-trial/azurefunctionsimage:1.0.1'
# $DockerBuildPath = './fntest'
# $DockerUser = 'L190339'

# DockerLogin -DockerLogin $DockerUser -Server $DockerServer
# DockerBuild -ImageTag $DockerImageTag -BuildPath $DockerBuildPath
# DockerPush -ImageTag $DockerImageTag
# DockerLogout -Server $DockerServer
