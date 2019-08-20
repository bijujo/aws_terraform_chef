# WordPress Assignment

Deploys WordPress in AWS using Terraform and Chef

### Terraform script deploys following resources in us-west-2 region
-  VPC
-  Public Subnet
-  Internet Gateway
-  Security Group allowing ports 22, 80 and 443. Presently open to 0.0.0.0/0
-  Route table and route table association
-  RHEL7.6 EC2 instance with a user data script for cloud-init
#### Variables such as VPC/Subnet CIDR's, AMI, region, instance type, etc are specified in vars.tf file
#### Successful terraform execution displays public IP of the instance that is hosting WordPress
#### During EC2 deployment, userdata script performs the following steps
-  Chefdk installed 
-  Chef recipes needed for installation of apache, php, mariadb and wordpress are cloned from my GitHub repo
-  Chef-solo executes all recipes specified in the run list
-  Recipes also create wordpress db, set root password for mariadb and configure wordpress config file for DB connection.

## Prerequisites

-  Download latest version of terraform executable to the workstation/server from where you plan to execute the script
-  Install AWS CLI and configure credentials using "aws configure". Credentials are needed for terraform to initialize s3 backend
-  git clone the repo
-  terraform init, plan, apply

## Sample run
```

$ terraform apply
var.aws_access_key
  Enter a value: XXXXXXXXXX

var.aws_secret_key
  Enter a value: XXXXXXXXXXXXXXXXXXXXXXXXXXX

Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.template_file.user_data_file: Refreshing state...

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_instance.wordpress_ec2
      id:                                          <computed>
      ami:                                         "ami-0a7e1ebfee7a4570e"
      arn:                                         <computed>
      associate_public_ip_address:                 <computed>

<< OUTPUT TRUNCATED >>

aws_instance.wordpress_ec2: Still creating... (30s elapsed)
aws_instance.wordpress_ec2: Creation complete after 35s (ID: <instance_id>)

Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

Wordpress_Instance_Public_IP = [
   <Public_IP_of_Instance> 
]
$

```

## References

https://www.terraform.io/intro/index.html

https://www.chef.io/

https://wordpress.org/support/article/how-to-install-wordpress/
