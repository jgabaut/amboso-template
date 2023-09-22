# Makefile.am

# Set the automake options
AUTOMAKE_OPTIONS = foreign

# Variables
CFLAGS = @CFLAGS@
PACKS_DIR = share
TARGET_INSTALL_DIR = $(HOME)/amboso-template-local
SOURCE_INSTALL_DIR = "."
STATIC_DIR_NAME = "static"
INSTALLER_LOG_FILE = "./installer.log"
ANVIL_HEADER = "anvil__hello_world"
# Check local version
RUN_VERSION := $$(./$(TARGET) -v)
# Specify the shell to use in the makefile
SHELL := /bin/bash
# Set the .ONESHELL special target to use a specific shell for all recipes
.ONESHELL:
# Check system info
MACHINE := $$(uname -m)
PACK_NAME = $(TARGET)-$(VERSION)-$(OS)-$(MACHINE)

# Source files
hello_world_SOURCES = src/hello_world.c src/$(ANVIL_HEADER).c

# Linking rule
LDADD = $(AMBOSO_TEMPLATE_LDFLAGS)
AM_LDFLAGS = -lm

if DEBUG_BUILD
AM_LDFLAGS += -ggdb -O0
AMBOSO_TEMPLATE_CFLAGS += -DAMBOSO_TMPL_DEBUG
else
# Linker flag to strip symbols
AM_LDFLAGS += -s -O2
endif

# Compiler flags
AM_CFLAGS = $(AMBOSO_TEMPLATE_CFLAGS) -Werror -Wpedantic -Wall

./src/$(ANVIL_HEADER).c:
	@echo -e "\033[1;34m[Makefile]\e[0m    Using \033[1;33mamboso\e[0m to generate [\033[1;34m./src/$(ANVIL_HEADER).c\e[0m and \033[1;34m./src/$(ANVIL_HEADER).h\e[0m] for [ \033[1;36m$(VERSION)\e[0m ]:"
	-./anwrap -qXG ./src $(VERSION)
	@echo -e "\033[1;33mDone.\e[0m"

# Build rule for object files
%.o: %.c
	@echo -e "    \033[1;35mAM_CFLAGS\e[0m: [ \"\033[1;34m$(AM_CFLAGS)\e[0m\" ]"
	@echo -en "    [ $< ] -> [ \033[1;34m$@\e[0m ]:  "
	$(CCOMP) -c $(CFLAGS) $(AM_CFLAGS) $< -o $@
	@echo -e "\033[1;33mDone.\e[0m"

# Build rule for the final binary
$(TARGET): $(hello_world_SOURCES:.c=.o)
	@echo -e "    \033[1;35mAM_CFLAGS\e[0m: [ \"\033[1;34m$(AM_CFLAGS)\e[0m\" ]"
	@echo -e "    \033[1;35mAM_LDFLAGS\e[0m: [ \"\033[1;34m$(AM_LDFLAGS)\e[0m\" ]"
	@echo -e "    \033[1;35mLDADD\e[0m: [ \"\033[1;34m$(LDADD)\e[0m\" ]"
	@echo -en "\033[1;34m[Makefile]    Building [\033[1;35m $@ \033[1;34m]:\e[0m  "
	$(CCOMP) $(CFLAGS) $(AM_CFLAGS) $(hello_world_SOURCES:.c=.o) -o $@ $(LDADD) $(AM_LDFLAGS)
	@echo -e "\033[1;33mDone.\e[0m"

# Targets for additional rules
versioncheck:
	@echo -en "Checking helapordo local version.\n\n    Expected ($(VERSION)),  got: ($(RUN_VERSION)).\n"
	@test "$(VERSION)" = "$(RUN_VERSION)" || echo -en '\n    \033[1;31mFailed check for expected local version.\e[0m\n'
	@echo -e "\n\033[1;32mDone.\e[0m"

pack: versioncheck
	@echo -e "Packing \033[1;34m$(TARGET)\e[0m:  make pack for $(VERSION)"
	@echo -e "\n    amboso version:"
	./anwrap -v
	@echo -e "\033[1;32m[TREE] Prepping tree, pack for $(VERSION):\e[0m"
	[[ -d $(TARGET_INSTALL_DIR)/ ]] || mkdir $(TARGET_INSTALL_DIR)
	[[ -d $(TARGET_INSTALL_DIR)/$(PACKS_DIR) ]] || mkdir $(TARGET_INSTALL_DIR)/$(PACKS_DIR)
	[[ -d $(TARGET_INSTALL_DIR)/$(PACKS_DIR)/$(PACK_NAME) ]] || mkdir $(TARGET_INSTALL_DIR)/$(PACKS_DIR)/$(PACK_NAME)
	[[ -d $(TARGET_INSTALL_DIR)/$(PACKS_DIR)/$(PACK_NAME)/$(STATIC_DIR_NAME) ]] || mkdir $(TARGET_INSTALL_DIR)/$(PACKS_DIR)/$(PACK_NAME)/$(STATIC_DIR_NAME)

	@echo -e "\033[1;32m[TREE] Removing '$(TARGET_INSTALL_DIR)/$(PACKS_DIR)/$(PACK_NAME).zip':\e[0m"
	touch $(TARGET_INSTALL_DIR)/$(PACKS_DIR)/$(PACK_NAME).zip
	rm $(TARGET_INSTALL_DIR)/$(PACKS_DIR)/$(PACK_NAME).zip
	@echo -e "\033[1;32m[TREE] Done.\e[0m"
	@echo -e "\033[1;35m[PACK] Installing $(TARGET):\e[0m"
	install ./$(TARGET) $(TARGET_INSTALL_DIR)/$(PACKS_DIR)/$(PACK_NAME)

	@echo -e "\033[1;35m[PACK] Done.\e[0m"
	@echo -e "\033[1;32m[ZIP] Compressing $(PACK_NAME):\e[0m"
	cd $(TARGET_INSTALL_DIR)/$(PACKS_DIR) && zip -r $(PACK_NAME).zip ./$(PACK_NAME)
	@echo -e "\033[1;33m[ZIP] Testing zip:\e[0m"
	echo -e "\033[1;36m[UNZIP] Result:\n"
	unzip -t $(TARGET_INSTALL_DIR)/$(PACKS_DIR)/$(PACK_NAME).zip | tail -n1
	@echo -e "\033[1;32m[ZIP] Done.\e[0m"
	@echo -e "\033[1;33mDone.\e[0m"

run: $(TARGET)
	@echo -en "Running ./$(TARGET).  "
	./$(TARGET)
	@echo -e "\033[1;33mDone.\e[0m"

install: $(TARGET)
	@echo -en "Installing $(TARGET) $(VERSION):  "
	./installer "-i" $(VERSION) $(TARGET_INSTALL_DIR) $(SOURCE_INSTALL_DIR) $(STATIC_DIR_NAME) $(INSTALLER_LOG_FILE)
	@echo -e "\033[1;33mDone.\e[0m"

do_alias:
	@echo -en "Symlinking ($(TARGET_INSTALL_DIR)/$(TARGET)) to /usr/local/bin/$(TARGET):  "
	@[[ -e /usr/local/bin/$(TARGET) ]] || sudo ln -s $(TARGET_INSTALL_DIR)/$(TARGET) /usr/local/bin/$(TARGET)
	@echo -e "\033[1;33mDone.\e[0m"

uninstall:
	@echo -en "Uninstalling $(TARGET):  "
	[[ -d $(TARGET_INSTALL_DIR) ]] && rm -rd $(TARGET_INSTALL_DIR)
	@echo -en "Deleting \033[1;31m/usr/local/bin/$(TARGET)\e[0m:  "
	sudo rm /usr/local/bin/$(TARGET)
	@echo -e "\033[1;33mDone.\e[0m"

clean:
	@echo -en "Cleaning build artifacts:  "
	-rm $(TARGET)
	-rm src/*.o
	-rm ./*.o
	-rm src/$(ANVIL_HEADER).*
	@echo -e "\033[1;33mDone.\e[0m"

cleanob:
	@echo -en "Cleaning object build artifacts:  "
	-rm src/*.o
	@echo -e "\033[1;33mDone.\e[0m"

# Default target (builds everything)
all: ./src/$(ANVIL_HEADER).c $(TARGET)

# Target to clean and rebuild
rebuild: clean all

# By default, build the binary
.DEFAULT_GOAL := all
