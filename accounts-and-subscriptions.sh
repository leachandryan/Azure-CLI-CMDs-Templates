#-------------Accounts and Subscriptions
#In Azure, an account is the primary identity used to log in and manage resources, 
#usually tied to a person or organization. A subscription is a logical container that holds resources like virtual machines, 
#databases, and storage, and it determines billing and usage limits. Multiple subscriptions can exist under one account, 
#each with its own permissions, budgets, and policies, allowing for organized management and billing of resources.

#lists all subscriptions assocatied with account
az account list --output table

#switchs to other subscription, will need subscription id
az account set --subscription <SubscriptionID>

#Get current Subscription Id
az account show --query id -o tsv