BIN_LIB = BARRYLIB
LIBLIST= $(BIN_LIB) $(BIN_LIB_ILE)
TOOLSLIB = BOBTOOLS
SYSTEM=-s
SHELL=/QOpenSys/usr/bin/qsh
IFSPATH = /tmp/tmp-122454i9jEWOVC8LM8/BARRYChange
LIBLIST=$(BIN_LIB)

LIB_TARGETS=$(BIN_LIB).lib

PGM_TARGETS=TEST010.RPGLE

PF_TARGETS= TEST01.PF

LF_TARGETS = TEST01A.LF

all: $(LIB_TARGETS) $(PGM_TARGETS) $(PF_TARGETS) $(LF_TARGETS)

%.lib:
	-system -qi "CRTLIB LIB($*)"

%.PF:                                                                  	
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QDDSSRC) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('$(IFSPATH)/$*.PF') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QDDSSRC.file/$*.mbr') MBROPT(*REPLACE)"
	system $(SYSTEM) "CRTPF FILE($(BIN_LIB)/$*) SRCFILE($(BIN_LIB)/QDDSSRC) SRCMBR($*)"
 
%.LF:                                                                                                       
	system "CPYFRMSTMF FROMSTMF('$(IFSPATH)/$*.LF') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QDDSSRC.file/$*.mbr') MBROPT(*REPLACE)"
	liblist -a $(LIBLIST);\
	system $(SYSTEM) "CRTLF FILE($(BIN_LIB)/$*) SRCFILE($(BIN_LIB)/QDDSSRC) SRCMBR($*)"               

%.PGM:
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QRPGLESRC) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('$(IFSPATH)/$*.RPGLE') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QDDSSRC.file/$*.mbr') MBROPT(*REPLACE)"
	system $(SYSTEM) "CRTRPGPGM PGM($(BIN_LIB)/$*)"
	
