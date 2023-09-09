



# ===================================================

default:build

clean:
	rm -rf build/*

.PHONY:configure
configure:
	cd build && cmake ..

.PHONY:build
build:
	cd build && make

.PHONY:mon
mon:
	stty -F /dev/ttyACM0 115200
	screen /dev/ttyACM0 

.PHONY:reboot
reboot:
	picotool reboot --usb --bus 3 --address 19 --force

.PHONY:upload
upload: 
	cp build/irmon.uf2 /media/teyrana/RPI-RP2/
