#
# Makefile for debugging and testing
#

DEVICE ?= bft
HOST ?= ambertec.local

all : update clean .build .deploy

clean : .clean-$(DEVICE)

.clean-bft :
	bitbake ambertec-bft-api ambertec-bft-web -c cleanall -f

.clean-core :

build: .build

.build :
	bitbake ambertec-$(DEVICE)-image

deploy: .deploy

.deploy :	
	scp images/ambertec-$(DEVICE).fw root@$(HOST):/tmp/firmware.fw
	ssh root@$(HOST) -C "/usr/sbin/firmware_install /tmp/firmware.fw && /sbin/reboot"

update: .update

.update :
	./oebb.sh update

config: .config

.config : 
	./oebb.sh config beaglebone
