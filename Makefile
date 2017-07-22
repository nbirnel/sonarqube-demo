keys/deployer:
	ssh-keygen -f $@

clean:
	rm -rf .terraform

.PHONY: clean
