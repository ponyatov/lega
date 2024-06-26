# var
MODULE  = $(notdir $(CURDIR))
NOW     = $(shell date +%d%m%y)
REL     = $(shell git rev-parse --short=4 HEAD)
BRANCH  = $(shell git rev-parse --abbrev-ref HEAD)
CORES  ?= $(shell grep processor /proc/cpuinfo | wc -l)

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
C += $(wildcard src/*.c*) $(wildcard meta/src/*.c*)
H += $(wildcard inc/*.h*) $(wildcard meta/inc/*.h*)
D += $(wildcard src/*.d*)
J += $(wildcard ./*.json)
F += $(wildcard lib/*.f*) lib/$(MODULE).ini
S += $(C) $(H) $(D) $(J) $(F)

# cfg
CFLAGS += -I$(INC) -I$(TMP) -std=c++17

# all
.PHONY: all build run test
all:
	$(MAKE) run
# $(MAKE) -C meta run
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

# rule
bin/$(MODULE): $(C) $(H)
	$(CXX) $(CFLAGS) -o $@ $(C) $(L)

# doc
.PHONY: doc
doc:

$(HOME)/doc/D/yazyk_programmirovaniya_d.pdf:
	$(CURL) $@ https://www.k0d.cc/storage/books/D/yazyk_programmirovaniya_d.pdf
$(HOME)/doc/D/Programming_in_D.pdf:
	$(CURL) $@ http://ddili.org/ders/d.en/Programming_in_D.pdf

.PHONY: doxy
doxy: .doxygen
	rm -rf docs ; doxygen $< 1>/dev/null

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

# merge
MERGE += Makefile README.md apt.txt LICENSE $(S)
MERGE += .clang-format .editorconfig .doxygen .gitignore .stignore
MERGE += .vscode bin doc lib inc src tmp ref meta

.PHONY: dev
dev:
	git push -v
	git checkout $@
	git pull -v
	git checkout shadow -- $(MERGE)
	$(MAKE) doxy && git add -f docs

.PHONY: shadow
shadow:
	git push -v
	git checkout $@
	git pull -v

.PHONY: release
release:
	git tag $(NOW)-$(REL)
	git push -v --tags
	$(MAKE) shadow

.PHONY: zip
zip:
	git archive \
		--format zip \
		--output $(TMP)/$(MODULE)_$(NOW)_$(REL).src.zip \
	HEAD
