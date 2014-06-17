#
# Makefile for debugging and testing
#

device ?= bft
host ?= ambertec.local

all : clean .build .deploy

clean : .clean-$(device)

.clean-bft :
	bitbake ambertec-bft-api ambertec-bft-web ambertec-dtb -c cleanall -f

.clean-core :
	bitbake ambertec-dtb -c cleanall -f

build: .build

.build :
	bitbake ambertec-$(device)-image

deploy: .deploy

.deploy :	
	scp images/ambertec-$(device).fw root@$(host):firmware.fw
	ssh root@$(host) -C "/usr/sbin/firmware_install firmware.fw && /sbin/reboot"

