# Tinland: build and test the editor with a tin checkout (TIN, default ../tin).
#
#   make build    the editor into bin/tinland (macOS)
#   make test     the test suite (portable parts everywhere, the editor on macOS)
#
# TIN points at a checkout of usetin/tin (the compiler, runtime, std and packages); it is built
# from its checked-in seed when needed.
TIN ?= ../tin
TINC := $(TIN)/bin/tinc

.PHONY: all build test app

all: build

build: $(TINC)
	@mkdir -p bin
	$(TIN)/tin build main.tin -o bin/tinland

# A bundle with its own Dock icon and name in the menu bar (macOS).
app: $(TINC)
	tools/dev/tinland_app.sh bin/app

test: $(TINC)
	TIN_ROOT=$(abspath $(TIN)) sh tests/run.sh $(abspath $(TINC))

$(TINC):
	$(MAKE) -C $(TIN) bin/tinc
