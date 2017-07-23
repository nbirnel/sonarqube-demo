
You will need:

* terraform https://www.terraform.io/downloads.html
* make
* ssh-keygen 


To get started::

    cd terraform 
    cp examples/* ./
    $EDITOR variables.tf
    $EDITOR secrets.tf
    make apply  # not yet implemented!

https://wiki.centos.org/Cloud/AWS#head-224024c7b3b083bd574bec6861bcdfd3487a5418
aws --region us-east-1 ec2 describe-images --owners aws-marketplace --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce

TODO
====

disk encryption?
salt states sonarqube
iptables?
test master key removal - does not wreck terraform plan
instructions
contributing
monitoring
gitfs
use modules for route53 records
discuss keys
discuss nacl -> sg -> iptables
discuss public IPs
discuss public git repos
discuss elastic IPs
tidy module outputs 
discuss ping

figure out timing of saltmaster and saltminion restarts
flesh our Makefile 
