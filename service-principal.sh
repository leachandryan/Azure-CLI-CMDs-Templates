#---------------------- Service Principals and Role Assignment

#A service principal in Azure is an identity created for an application to securely access resources. 
#It’s like a user account but for apps, with specific permissions assigned, ensuring secure, 
#limited access without using personal credentials.

#------------------Create/Manage Role

#Creates Role using json config file. Refer ro /templates folder for example file
az role definition create --role-definition vmStartRole.json

#------------------Create/Manage Principal

#List all service principals
az ad sp list --query "[].{Name:displayName, AppId:appId, ObjectId:objectId}"

#Look up with parial name, replace my app with partial query
az ad sp list --query "[?contains(displayName, '<My App>')].{Name:displayName, ObjectId:objectId}" -o table

#Gets object id for principal, need prinicapl-name
az ad sp list --display-name "principal-name" --query "[0].objectId" -o tsv

#Create Service Principal
az ad sp create-for-rbac --name "vm-test" --role "Contributor" --scopes /subscriptions/<SubscriptionID>/resourceGroups/MyResourceGroup

#Creates Principal with role
az ad sp create-for-rbac --name "vm-restart-principal" --role "Contributor" --scopes /subscriptions/1166f771-f229-4ba3-ad15-eee39608c4bf/resourceGroups/gv-dittofeed

#Delete Principal, replace MyServicePrincipal
az ad sp delete --id $(az ad sp list --display-name "MyServicePrincipal" --query "[0].objectId" -o tsv)

#This commands adds a role to Service Princpal, will need Principal Object ID, role name, subscription id, and resource group name. 
az role assignment create --assignee <ServicePrincipalObjectID> --role "Virtual Machine Contributor" --scope /subscriptions/<SubscriptionID>/resourceGroups/<ResourceGroupName>

#Creats role assignment and assgns it to Principal
az role assignment create --assignee 38deb9bd-f074-471b-a6af-8761f10731c9 --role "VM Start Only Role" --scope "/subscriptions/1166f771-f229-4ba3-ad15-eee39608c4bf/resourceGroups/gv-dittofeed"

#Confirm Service Principle has role assigned
az role assignment list --assignee 38deb9bd-f074-471b-a6af-8761f10731c9 -o table
