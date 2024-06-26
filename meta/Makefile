# var
MODULE = $(notdir $(CURDIR))

# dirs
CWD   = $(CURDIR)
INC   = $(CWD)/inc
SRC   = $(CWD)/src
TMP   = $(CWD)/tmp

# src
C += $(wildcard src/*.c*)
H += $(wildcard inc/*.h*)
F += $(wildcard lib/*.f*) lib/$(MODULE).ini

# cfg
CFLAGS += -I$(INC) -I$(TMP)

# all
.PHONY: all build run
all: build
build: bin/$(MODULE)
run: bin/$(MODULE) $(F) 
	$^

# format
.PHONY: format
format: tmp/format_c
tmp/format_c: $(C) $(H)
	$(CF) -i $? && touch $@

# rulemake -
bin/$(MODULE): $(C) $(H)
	$(CXX) $(CFLAGS) -o $@ $(C) $(L)

# doc
.PHONY: doc
doc:

.PHONY: doxy
doxy: .doxygen
	rm -rf docs ; doxygen $< 1>/dev/null

# install
.PHONY: install update ref gz
install: doc ref gz
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -yu `cat apt.txt`
ref:
gz:
