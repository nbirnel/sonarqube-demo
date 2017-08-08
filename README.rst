=====================
Sonarqube in AWS demo
=====================

This creates a VPC with four subnets: 
a utilities subnet and a sonarqube subnet in two availability zones.
The utilities subnet currently has only a SaltStack salt master,
but would also be the place to put, for example,
a VPN server, an NTP server, etc.

Getting Started
===============

You will need:

* terraform https://www.terraform.io/downloads.html
* make
* ssh-keygen 
* A POSIX-like shell (bash or zsh work)
* an AWS account
   - a user with AdministratorAccess
     (or otherwise the ability to create most types of resources in your chosen region)
   - the AWS Access Key and AWS Secret Key for that account

To get started::

    cd terraform 
    cp examples/* ./
    $EDITOR variables.tf
    $EDITOR secrets.tf
    make all
    terraform plan --out=initial.plan
    terraform apply initial.plan

Details
=======

`variables.tf` is intended for non-sensitive but organization-specific 
details:
the region, the CIDR blocks to use, etc.
It is excluded from version control.

`secrets.tf` is intended for sensitive data:
AWS keys, which CIDR blocks to allow access from, etc.
It is excluded from version control.

`make all` generates a key for ssh access to all instances,
and the salt master's key. 
These are stashed locally.
It is likely you will run this only once,
unless you like to repeatedly tear down your infratructure.

`terraform plan` shows what terraform intends to do if it is run.
Giving it the out flag creates a file guranteeing that this is what will be 
attempted.
It is deliberately not included in `make all`.

`terraform apply` applys the terraform plan,
creating any resources which are not already in place.
It is deliberately not included in `make all`.

What happens in the first apply
===============================

VPC, subnets, routes, etc are created.
The instances are created and given user data:

* The salt master installs salt,
  clones a public repo of salt states, 
  and runs a highstate on itself.
* Sonarqube installs the salt-minion,
  points it at the salt master,
  and runs a highstate on itself.

Code organization
=================

Salt states in one folder, 
terraform in another.

Terraform is organized into modules. 
A refactor of these modules might be in order;
salt and sonarqube could be refactored into a single ec2 module.

Thinking about security
=======================

The salt master key is generated on the local machine that runs `make all`.
Running `make clean` removes this,
but this is not perfect on SSD drives. 

The ec2 instances' disks are not encrypted. 
There are convenience tradeoffs here.

The instances have public IPs which are protected only AWS security groups.
While this is in theory secure, 
any mistake in the security group could leave the instances exposed. 
Defense in depth would call for
host-based iptables, 
or private IPs connected to over a VPN,
or both.

Placing Sonarqube's SQL on a high availability RDS in set of private subnets
would somewhat protect the db in case of a Sonarqube compromise.

Adding a scanning service,
both public and private,
would help catch misconfigures.

TODO
====

* salt states sonarqube
* monitoring
* gitfs (to use github directly for saltstates, rather than cloning).
* use modules for route53 records
* add a salt pillar, on the same model as the terraform `secrets.tf`
* elastic IPs
* add a data source for AMIs, rather than hard coding
  https://wiki.centos.org/Cloud/AWS#head-224024c7b3b083bd574bec6861bcdfd3487a5418
  `aws --region us-east-1 ec2 describe-images --owners aws-marketplace --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce`

