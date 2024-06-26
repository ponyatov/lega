# var
MODULE  = $(notdir $(CURDIR))

# version
DMD_VER = 2.109.0

# dirs
CWD   = $(CURDIR)
BIN   = $(CWD)/bin
INC   = $(CWD)/inc
SRC   = $(CWD)/src
TMP   = $(CWD)/tmp
REF   = $(CWD)/ref
GZ    = $(HOME)/gz
DISTR = $(HOME)/distr
BUILD = $(CWD)/tmp/$(MODULE)

# tool
CURL   = curl -L -o
CF     = clang-format -style=file
REF    = git clone --depth 1 -o gh
DUB    = /usr/bin/dub
DMD    = /usr/bin/dmd
DC     = $(DMD)
RUN    = $(DUB) run   --compiler=$(DC)
BLD    = $(DUB) build --compiler=$(DC)
TEST   = $(DUB) test  --compiler=$(DC)

# package
DMD_DEB = dmd_$(DMD_VER)-0_amd64.deb
DMD_URL = https://downloads.dlang.org/releases/2.x

# src
C += $(wildcard src/*.c*)
H += $(wildcard src/*.h*)
D += $(wildcard src/*.d*)
F += $(wildcard lib/*.f*) lib/$(MODULE).ini
S  = $(C) $(H) $(D) $(F)

# cfg
CFLAGS += -I$(INC) -I$(TMP)

# all
.PHONY: all build run test
all: run
build: $(S)
	$(BLD)
run: $(S)
	$(RUN) -- $(F)
test: $(S)
	$(TEST)

# format
.PHONY: format
format: tmp/format_c tmp/format_d
tmp/format_c: $(C) $(H)
	$(CF) -i $? && touch $@
tmp/format_d: $(D)
	$(RUN) dfmt -- -i $? && touch $@

# doc
.PHONY: doc
doc:

# install
.PHONY: install update ref gz
install: doc ref gz $(DUB)
	$(MAKE) update
	$(BLD)  dfmt
update:
	sudo apt update
	sudo apt install -yu `cat apt.txt`
ref:
gz:

$(DUB): $(DISTR)/Linux/tools/$(DMD_DEB)
	sudo dpkg -i $< && sudo touch $@
$(DISTR)/Linux/tools/$(DMD_DEB):
	$(CURL) $@ $(DMD_URL)/$(DMD_VER)/$(DMD_DEB)f
