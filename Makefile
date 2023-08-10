M                   = $(shell printf "\033[34;1m▶\033[0m")
SHELL              := /bin/bash

HELPER              = helper
BIN                 = $(HELPER)/usr/local/bin
export PATH        := $(BIN):$(PATH)

include make/helper.mk
include make/site.mk
