BIN_LIB = BARRYLIB

all: $(BIN_LIB).lib inventory.sql

%.lib:
	-system -qi "CRTLIB $(BIN_LIB)

