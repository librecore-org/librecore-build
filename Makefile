RELEASE ?=4.6

all:
	@echo "Available targets: 'get-deblob-coreboot', 'get-dev-librecore', 'test-all', 'BOARD=vendor/model rom'"

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

test-all:
	@if [ ! -d $(RELEASE)/librecore-$(RELEASE) ]; then \
		echo "Missing source code: run 'make get-dev-librecore' or 'make get-deblob-coreboot'"; \
	else \
		cd $(RELEASE)/librecore-$(RELEASE) && ../../scripts/test-build-all.sh; \
	fi

rom:
	@if [ ! -d $(RELEASE)/librecore-$(RELEASE) ]; then \
		echo "Missing source code: run 'make get-dev-librecore' or 'make get-deblob-coreboot'"; \
	else \
		if [ -z "$(BOARD)" ]; then \
			echo "BOARD= unset...exiting"; \
		else \
			rm -fr build && \
			cd $(RELEASE)/librecore-$(RELEASE) && \
			./util/abuild/abuild -t $(BOARD) -o ../../build --timeless -p none -c j4 ; \
		fi \
	fi
