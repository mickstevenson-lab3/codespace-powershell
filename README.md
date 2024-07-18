# codespace-powershell


https://contosotest.jfrog.io/artifactory/a015c0_dbp-generic-local/



L190339
Password!@1234

https://contosotest.jfrog.io/artifactory/a015c0_dbp-generic-local/assets/test.txt




Setup:

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

Modules:
Install-Module -Name Az -Repository PSGallery -Force

Net Framework:
sudo apt-get update && sudo apt-get install -y dotnet-sdk-8.0
sudo apt-get install -y dotnet-runtime-8.0

sudo apt-get update && sudo apt-get install -y dotnet-sdk-6.0
sudo apt-get install -y dotnet-runtime-6.0

Azure Functions:
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list'
sudo apt-get update
sudo apt-get install azure-functions-core-tools-4


===============================================================================
https://learn.microsoft.com/en-us/azure/azure-functions/functions-how-to-custom-container?tabs=core-tools%2Cacr%2Cazure-cli2%2Cazure-cli&pivots=container-apps
https://learn.microsoft.com/en-us/azure/azure-functions/functions-create-container-registry#create-and-test-the-local-functions-project



func init --worker-runtime powershell --docker
func new --name HttpExample --template "HTTP trigger"

docker build --tag azurefunctionsimage/azurefunctionsimage:v1.0.0 .
docker run -p 8080:80 -it azurefunctionsimage/azurefunctionsimage:v1.0.0

===============================================================================
ASE: ase-fn-app-poc

https://learn.microsoft.com/en-us/cli/azure/appservice?view=azure-cli-latest



docker login -ul190339 contosotest.jfrog.io
cmVmdGtuOjAxOjE3NTI3MTg5OTU6NDA0NWJqcEkyYzJlN3dwMUJ6Z1Y2ZDM3Q1p3


docker tag 03ea00221327 contosotest.jfrog.io/docker-trial/azurefunctionsimage:1.0.0
docker push contosotest.jfrog.io/docker-trial/azurefunctionsimage:1.0.0

https://contosotest.jfrog.io/artifactory/docker-trial/

az functionapp create -g t3-genai-lab01-arg01 -p asp-fnapp-cli -n fncli -s fnappcli --image contosotest.jfrog.io/docker-trial/azurefunctionsimage:1.0.0 --registry-password cmVmdGtuOjAxOjE3NTI3MTg5OTU6NDA0NWJqcEkyYzJlN3dwMUJ6Z1Y2ZDM3Q1p3 --registry-username L190339




az cognitiveservices account deployment create \
--name <myResourceName> \
--resource-group <myResourceGroupName> \
--deployment-name MyModel \
--model-name GPT-4 \
--model-version 0613  \
--model-format OpenAI \
--sku-capacity 100 \
--sku-name ProvisionedManaged


# TODO: pull from bitbucket for application code
