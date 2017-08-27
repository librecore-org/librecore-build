RELEASE ?=4.6

all:
	@echo "Available targets: 'get-deblob-coreboot', 'get-dev-librecore', 'test-all', 'BOARD=vendor/model rom', 'clean', 'payloads'"

get-dev-librecore:
	$(shell mkdir -p $(RELEASE))
	$(shell rm -fr $(RELEASE)/librecore-$(RELEASE))
	$(shell cd $(RELEASE) && ../scripts/get-librecore.sh $(RELEASE))
	$(shell cd $(RELEASE) && ../scripts/get-microcode.sh $(RELEASE))

get-deblob-coreboot:
	$(shell mkdir -p $(RELEASE))
	$(shell rm -fr $(RELEASE)/librecore-$(RELEASE))
	$(shell cd $(RELEASE) && ../scripts/get-coreboot.sh $(RELEASE))
	$(shell cd $(RELEASE) && ../scripts/deblob-coreboot.sh $(RELEASE))
	$(shell cd $(RELEASE) && ../scripts/get-microcode.sh $(RELEASE))

payloads/SeaBIOS/seabios:
	@$(MAKE) -C payloads/SeaBIOS CONFIG_SEABIOS_STABLE=y CONFIG_SEABIOS_VGA_COREBOOT=y fetch

payloads: payloads/SeaBIOS/seabios
	@$(MAKE) -C payloads/SeaBIOS CONFIG_SEABIOS_STABLE=y CONFIG_SEABIOS_VGA_COREBOOT=y \
		HOSTCC=gcc \
		CC=i386-elf-gcc \
		LD=i386-elf-ld \
		OBJDUMP=i386-elf-objdump \
		OBJCOPY=i386-elf-objcopy \
		STRIP=i386-elf-strip \
		AS=i386-elf-as \
		IASL=iasl

clean-payloads:
	@$(MAKE) -C payloads/SeaBIOS CONFIG_SEABIOS_STABLE=y CONFIG_SEABIOS_VGA_COREBOOT=y clean

clean: clean-payloads
	@rm -fr build
	@rm -fr $(RELEASE)/librecore-$(RELEASE)/coreboot-builds

test-all: clean
	@if [ ! -d $(RELEASE)/librecore-$(RELEASE) ]; then \
		echo "Missing source code: run 'make get-dev-librecore' or 'make get-deblob-coreboot'"; \
	else \
		cd $(RELEASE)/librecore-$(RELEASE) && ../../scripts/test-build-all.sh; \
	fi

rom: clean
	@if [ ! -d $(RELEASE)/librecore-$(RELEASE) ]; then \
		echo "Missing source code: run 'make get-dev-librecore' or 'make get-deblob-coreboot'"; \
	else \
		if [ -z "$(BOARD)" ]; then \
			echo "BOARD= unset...exiting"; \
		else \
			cd $(RELEASE)/librecore-$(RELEASE) && \
			./util/abuild/abuild -t $(BOARD) -o ../../build --timeless -p none -c j4 ; \
		fi \
	fi

.PHONY: all get-deblob-coreboot get-dev-librecore clean clean-payloads test-all rom
