#
# Makefile for debugging and testing
#

device ?= bft
host ?= ambertec.local

clean-bft:
	bitbake ambertec-bft-api ambertec-bft-web ambertec-dtb -c cleanall -f

clean-core:
	bitbake ambertec-dtb -c cleanall -f

clean: clean-$(device)

build:
	bitbake ambertec-$(device)-image

deploy:	
	scp images/ambertec-$(device).fw root@$(host):firmware.fw
	ssh root@$(host) -C "/usr/sbin/firmware_install firmware.fw && /sbin/reboot"

all:	clean build deploy


