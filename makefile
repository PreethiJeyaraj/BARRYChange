BIN_LIB = BARRYLIB

all: $(BIN_LIB).lib inventory.sql

%.lib:
	-system -qi "CRTLIB $(BIN_LIB)

%.rpgle:
	system "CRTBNDRPG PGM($(BIN_LIB)/$*) SRCSTMF('QSOURCE/$*.rpgle') TEXT('$(NAME)') REPLACE(*YES)
