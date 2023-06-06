export SHELL=/bin/bash
VERSION="1.4.8-b"
TEMPLATE_VERSION="0.2.3-b"
ECHO_VERSION="./anwrap"
RUN_VERSION := $(shell $(ECHO_VERSION) -v)

all: hello_world
	@echo -e "\033[1;32mEnd of build.\e[0m\n"
.PHONY: all

init_submodules:
	@echo -en "Initialising submodules for amboso-template ($(TEMPLATE_VERSION)):    "
	git submodule update --init
	@echo -e "\033[1;33mDone.\e[0m"

hello_world: .hello_world.o .amboso.o
	@echo -en "Building hello_world for amboso-template ($(TEMPLATE_VERSION)):    "
	gcc .hello_world.o .amboso.o -o hello_world
	@echo -e "\033[1;33mDone.\e[0m"

check:
	@echo -e "Checking anwrap local version, expected  ($(VERSION)):    got  ($(RUN_VERSION)).\n"
	test $(RUN_VERSION) = $(VERSION) || echo -en '\n    \033[1;31mFailed check for expected local version.\e[0m\n'
	@echo -e "\033[1;32mDone.\e[0m"

distcheck: hello_world
	@echo -en "Distchecking amboso $(VERSION):    "
	echo -e "Feeling good.\n"
	@echo -e "\033[1;32mSuccess.\e[0m"

.hello_world.o: ./src/hello_world.c
	@echo -en "Building .hello_world.o for amboso-template ($(TEMPLATE_VERSION)):    "
	gcc -c ./src/hello_world.c -o .hello_world.o
	@echo -e "\033[1;33mDone.\e[0m"

.amboso.o: ./static/amboso.c
	@echo -en "Building .amboso.o for amboso-template ($(TEMPLATE_VERSION)):    "
	gcc -c ./static/amboso.c -o .amboso.o
	@echo -e "\033[1;33mDone.\e[0m"

clean:
	@echo -en "Cleaning build artifacts:    "
	rm \.*.o hello_world
	@echo -e "\033[1;33mDone.\e[0m"

cleanob:
	@echo -en "Cleaning object build artifacts:    "
	rm \.*.o
	@echo -e "\033[1;33mDone.\e[0m"

$(V).SILENT:
