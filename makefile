
# ===================================================
default:build

clean:
	rm -rf build/*

.PHONY:config
config: build/CMakeCache.txt

build/CMakeCache.txt:
	cd build && cmake ..

build/irmon.uf2: build

.PHONY:build
build: build/CMakeCache.txt $(SRCS)
	cd build && make

.PHONY:mon
mon: 
	stty -F /dev/ttyACM0 115200
	screen /dev/ttyACM0 

reboot:reset

.PHONY:reset
reset:
	$(eval ADDR:=$(shell lsusb | grep Pico | cut -c16-18))
	@echo ":> Rebooting device at Address:${ADDR}"
	picotool reboot --usb --bus 3 --address ${ADDR} --force
	sleep 3

.PHONY:run
run: reboot upload

.PHONY:upload
upload: build/irmon.uf2
	cp build/irmon.uf2 /media/teyrana/RPI-RP2/
	sleep 2

cpy:
	cp tools/i2c-scan.py /media/teyrana/CIRCUITPY/main.py