# Prerequisites

Before beginning the installation process, ensure that you have:

- AWS account user with admin privileges for resources deployment.

# Setup AWS Credentials

## Install AWS CLI

Before installing any new software, it is recommended to update your system’s package list. You can update your system with the following command:

`sudo apt update`

`sudo apt upgrade`

Use the below command to install AWS CLI on Ubuntu.

`sudo apt install awscli`

## Configure AWS CLI

Use the below command to configure AWS credentials.

`aws configure`

Provide the user access key, secret key, and aws region.

# Setup Terraform

## Install Terraform

### Step 1: Update the System

You’ll need curl and some software-properties-common packages to add the repository key and repository. Run the following commands to install them:

`sudo apt install curl software-properties-common`

### Step 2: Add the HashiCorp Repository

Terraform is developed by HashiCorp, and you need to add the HashiCorp GPG (GNU Privacy Guard) key with the following command:

`wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg`

Once the key is added, add the HashiCorp repository to your system:

`echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list`

### Step 3: Install Terraform

After adding the repository, you can install Terraform with the following command:

`sudo apt update && sudo apt install terraform`

### Step 4: Verify the Installation

To ensure Terraform has been installed successfully, check the version with the following command:

`terraform version`

You should see the version of your installed Terraform.

# Get Started with Terraform

Now that Terraform is installed, you can start using it to manage and automate your infrastructure. Navigate to project folder terraform.

`cd terraform`

Configure credentials for Terraform. Open the file providers.tf and provide the AWS credentials profile accordingly. Set the desired AWS region by editing the variables.tf region variable default string value. You can also change other options in that file as well like bucket name etc.

Initialize the terraform directory with the below command.

`terraform init`

Once terraform is initialized then we have to plan our infrastructure for resources deployment. That is how we can plan the changes.

`terraform plan -out carlsmed.tfstate`

Once the plan is successful and all changes are verified then we have to apply the resources. We can do that with below command.

`terraform apply carlsmed.tfstate`

Upon entering the above command you will see that resources began to deploy.
