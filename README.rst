
You will need:

* terraform https://www.terraform.io/downloads.html
* make
* ssh-keygen 


To get started::

    cp samples/* ./
    $EDITOR variables.tf
    $EDITOR secrets.tf
    make key     # creates a deploy ssh key - you may wish to passphrase protect it. 
    make apply

https://wiki.centos.org/Cloud/AWS#head-224024c7b3b083bd574bec6861bcdfd3487a5418
aws --region us-east-1 ec2 describe-images --owners aws-marketplace --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce

TODO
====

disk encryption?
salt-minion bootstrap for sonarqube
salt states sonarqube
iptables?
test master key removal
instructions
monitoring
gitfs
route53? and the hardcoded IPs 
discuss keys
discuss nacl -> sg -> iptables
discuss public IPs
discuss public git repos
discuss elastic IPs
