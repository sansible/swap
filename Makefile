
BRANCH?=$(shell git rev-parse --abbrev-ref HEAD)

all: test clean

watch: test_deps
	while sleep 1; do \
		find defaults/ handlers/ meta/ tasks/ templates/ tests/test.yml \
		| entr -d make vagrant_up; \
	done

test: test_deps vagrant_up

integration_test: clean integration_test_deps vagrant_up clean

test_deps:
	rm -rf tests/sansible.*
	ln -s .. tests/sansible.swap

integration_test_deps:
	sed -i.bak \
		-E 's/(.*)version: (.*)/\1version: origin\/$(BRANCH)/' \
		tests/integration_requirements.yml
	rm -rf tests/sansible.*
	ansible-galaxy install -p tests -r tests/integration_requirements.yml
	mv tests/integration_requirements.yml.bak tests/integration_requirements.yml

vagrant_up:
	cd tests/vagrant && vagrant up --no-provision
	cd tests/vagrant && vagrant provision

vagrant_ssh:
	cd tests/vagrant && vagrant up --no-provision
	cd tests/vagrant && vagrant ssh

clean:
	rm -rf tests/sansible.*
	cd tests/vagrant && vagrant destroy
