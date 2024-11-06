#---------------------- Service Principals and Role Assignment

#A service principal in Azure is an identity created for an application to securely access resources. 
#It’s like a user account but for apps, with specific permissions assigned, ensuring secure, 
#limited access without using personal credentials.

#List all service principals
az ad sp list --query "[].{Name:displayName, AppId:appId, ObjectId:objectId}"

#Look up with parial name, replace my app with partial query
az ad sp list --query "[?contains(displayName, '<My App>')].{Name:displayName, ObjectId:objectId}" -o table

#Gets object id for principal, need prinicapl-name
az ad sp list --display-name "principal-name" --query "[0].objectId" -o tsv

#Create Service Principal
az ad sp create-for-rbac --name "MyNewServicePrincipal" --role "Contributor" --scopes /subscriptions/<SubscriptionID>/resourceGroups/MyResourceGroup

#Creates Principal with role
az ad sp create-for-rbac --name "vm-restart-principal" --role "Contributor" --scopes /subscriptions/<SubscriptionID>/resourceGroups/MyResourceGroup

#Creates Principal using json config file. Refer ro /templates folder for example file
az role definition create --role-definition vmStartRole.json

#Delete Principal, replace MyServicePrincipal
az ad sp delete --id $(az ad sp list --display-name "MyServicePrincipal" --query "[0].objectId" -o tsv)

#This commands adds a role to Service Princpal, will need Principal Object ID, role name, subscription id, and resource group name. 
az role assignment create --assignee <ServicePrincipalObjectID> --role "Virtual Machine Contributor" --scope /subscriptions/<SubscriptionID>/resourceGroups/<ResourceGroupName>


