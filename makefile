BIN_LIB = BARRYLIB

all: $(BIN_LIB).lib inventory.sql

%.lib:
	-system -qi "CRTLIB $(BIN_LIB)

%.sql:
	sed -i.bak "s/BIN_LIB/$(BIN_LIB)/g" ./$*.sql
	system "RUNSQLSTM SRCSTMF('./$*.sql') COMMIT(*NONE)"