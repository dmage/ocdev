all: all-steps

seed/user-data: seed/user-data.sh
	$< >$@

drives/seed.iso: seed/user-data seed/meta-data
	mkdir -p ./drives
	mkisofs -J -l -R -V "cidata" -iso-level 4 -o $@ $^

steps/step0:
	mkdir -p ./steps
	touch $@

# STEP 1
# Download Fedora 30
steps/step1: steps/step0
	mkdir -p ./drives
	wget https://download.fedoraproject.org/pub/fedora/linux/releases/30/Cloud/x86_64/images/Fedora-Cloud-Base-30-1.2.x86_64.raw.xz -O ./drives/fedora.raw.xz
	unxz ./drives/fedora.raw.xz
	qemu-img resize -f raw ./drives/fedora.raw +10G
	touch $@

# STEP 2
# Run a virtual machine and copy helper scripts into it
steps/step2: steps/step1 drives/seed.iso
	./start.sh || true
	for i in 1 2 3 4 5 6 7 8 9; do ./ssh.sh true && break; sleep 3; done
	./scp.sh ./src/* cloud@localhost:
	touch $@

# STEP 3
# Install Docker that can be used by `oc cluster up`
steps/step3: steps/step2
	./ssh.sh ./prepare-for-openshift.sh
	touch $@
	@echo
	@echo "Useful commands:"
	@echo "./ssh.sh [<command>]                          get into the virtual machine"
	@echo "./scp.sh <files...> cloud@localhost:<path>    copy files into the virtual machine"

.PHONY: all-steps
all-steps: steps/step3

# clean removes all generated files (including the disk image) and allows you
# to start from scratch
.PHONY: clean
clean:
	-rm -vrf ./seed/user-data ./steps ./drives
