keys: keys/deployer keys/master 

keys/deployer:
	ssh-keygen -f $@

keys/master:
	ssh-keygen -f $@

pillar: pillar/sonarqube.sls pillar/postgres.sls

pillar/sonarqube.sls:
	printf 'sonarqube:\n' >$@
	printf '  postgres_password: ' >>$@
	pwgen -y 16 1 >>$@

pillar/postgres.sls:
	printf 'postgres:\n' >$@
	printf '  password: ' >>$@
	pwgen -y 16 1 >>$@

pillar_deploy: pillar
	$$(terraform output salt-01-pillar)
	$$(terraform output salt-01-ssh) "sudo cp -a pillar/ /srv/"
	$$(terraform output salt-02-pillar)
	$$(terraform output salt-02-ssh) "sudo cp -a pillar/ /srv/"

apply:
	terraform apply

all: keys apply pillar_deploy

clean:
	shred -u .terraform keys/master keys/master.pub

.PHONY: clean pillar pillar_deploy all keys 
