all: keys/deployer keys/master 

keys/deployer:
	ssh-keygen -f $@

keys/master:
	ssh-keygen -f $@

clean:
	shred -u .terraform keys/master keys/master.pub

pillar: pillar/sonarqube.sls pillar/postgres.sls

pillar/sonarqube.sls:
	mkdir -p pillar
	printf 'sonarqube:\n' >$@
	printf '  postgres_password: ' >>$@
	pwgen -y 16 1 >>$@

pillar/postgres.sls:
	mkdir -p pillar
	printf 'postgres:\n' >$@
	printf '  password: ' >>$@
	pwgen -y 16 1 >>$@

.PHONY: clean
