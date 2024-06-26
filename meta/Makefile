# var
MODULE = $(notdir $(CURDIR))

# dirs
CWD   = $(CURDIR)
INC   = $(CWD)/inc
SRC   = $(CWD)/src
TMP   = $(CWD)/tmp

# src
C += $(wildcard src/*.c*)
H += $(wildcard src/*.h*)
F += $(wildcard lib/*.f*) lib/$(MODULE).ini

# cfg
CFLAGS += -I$(INC) -I$(TMP)

# all
.PHONY: all build run
all: build
build: bin/$(MODULE)
run: bin/$(MODULE) $(F) 
	$^

# rule
bin/$(MODULE): $(C) $(H)
	$(CXX) $(CFLAGS) -o $@ $(C) $(L)
