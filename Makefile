all: keys/deployer keys/master 

keys/deployer:
	ssh-keygen -f $@

keys/master:
	ssh-keygen -f $@

clean:
	rm -rf .terraform

.PHONY: clean
