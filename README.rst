=====================
Sonarqube in AWS demo
=====================

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
    make apply  # not yet implemented!

TODO
====

* disk encryption?
* salt states sonarqube
* iptables?
* test master key removal - does not wreck terraform plan
* instructions
* contributing
* monitoring
* gitfs
* use modules for route53 records
* discuss keys
* discuss nacl -> sg -> iptables
* discuss public IPs
* discuss public git repos
* discuss elastic IPs
* tidy module outputs 
* discuss ping
* figure out timing of saltmaster and saltminion restarts
* flesh our Makefile 
* discuss data source for AMIs

https://wiki.centos.org/Cloud/AWS#head-224024c7b3b083bd574bec6861bcdfd3487a5418

aws --region us-east-1 ec2 describe-images --owners aws-marketplace --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce

