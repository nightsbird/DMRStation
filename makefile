RM := rm -rf


CC = gcc

OBJ_DIR = Obj
CFLAGS = -Wall -o -g -O2 `pkg-config --cflags gtk+-3.0 libcrypto`
PACKAGE = `pkg-config --cflags --libs gtk+-3.0 libcrypto`
LIBS = `pkg-config --libs gtk+-3.0 libcrypto` -lpulse -lpulse-mainloop-glib
LDFLAGS=`pkg-config --libs gtk+-3.0`
PULSE_LIBS = -lpulse

OBJS += \
./src/dmr/BPTC19696.o \
./src/dmr/CRC.o \
./src/dmr/DMREmbeddedData.o \
./src/dmr/DMRFullLC.o \
./src/dmr/DMRLC.o \
./src/dmr/DMRShortLC.o \
./src/dmr/DMRSlotType.o \
./src/dmr/Hamming.o \
./src/dmr/QR1676.o \
./src/dmr/RS129.o \
./src/dmr/dmrDefines.o \
./src/dmr/dmrUtils.o 

OBJS += \
./src/ambe_client.o \
./src/codec2_client.o \
./src/audio.o \
./src/config.o \
./src/dmr.o \
./src/dmrids.o \
./src/fw_mbelib.o \
./src/lastheard.o \
./src/gpio.o \
./src/main.o \
./src/net.o \
./src/ptt.o \
./src/resources.o \
./src/talkgroup.o 

# Add inputs and outputs from these tool invocations to the build variables 

# All Target
all: resources DMRstation

resources:
	glib-compile-resources --target=./src/resources.c --sourcedir=./data/ --generate data/resources.xml 


# Tool invocations
DMRstation: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	gcc -L/usr/lib -o "DMRstation" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(EXECUTABLES)$(OBJS)$(C_DEPS) DMRstation
	-@echo ' '

.PHONY: all clean dependents
