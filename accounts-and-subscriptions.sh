#-------------Accounts and Subscriptions

#lists all subscriptions assocatied with account
az account list --output table

#switchs to other subscription, will need subscription id
az account set --subscription <SubscriptionID>

#Get current Subscription Id
az account show --query id -o tsv