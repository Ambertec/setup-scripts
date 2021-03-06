#
# Makefile for debugging and testing
#

DEVICE ?= bft
HOST ?= ambertec.local

all : update clean build deploy

clean : .clean .clean-$(DEVICE)

.clean :

.clean-bft :

.clean-vhusb :

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
