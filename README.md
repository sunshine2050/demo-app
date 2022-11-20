# Demo App

Demo App is a A Flask app which is connected to SQL server using pyodbc, the app is to be deployed on Azure using Terraform.

## Prerequisites
- Self Hosted agent has docker, terraform installed and docker.config is added
- Pool is defined in Azure DevOps has the name Ubuntu
- Storage account to store terraform state files as defined in terraform backend in main.tf file (you can run terraform apply on terraform/static dir)
- App registrations in Azure Active Directory with access to all resources 
- Terraform environmental variables are set by Azure DevOps 
## Installation

App is automatically deployed to Azure with any commit by Azure pipelines

## CI/CD
- Update the db_conf file with db_user and db_pass
- Build dockerfile
- Push docker image to dockerhub
- Run terraform
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
