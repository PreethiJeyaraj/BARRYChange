BIN_LIB = BARRYLIB
LIBLIST= $(BIN_LIB) $(BIN_LIB_ILE)
TOOLSLIB = BOBTOOLS
SYSTEM=-s
SHELL=/QOpenSys/usr/bin/qsh

LIB_TARGETS=$(BIN_LIB).lib

PGM_TARGETS=TEST010.RPGLE

PF_TARGETS= TEST01.PF

LF_TARGETS = TEST01A.LF

all: $(LIB_TARGETS) $(PGM_TARGETS) $(PF_TARGETS) $(LF_TARGETS)

%.lib:
	-system -qi "CRTLIB LIB($*)"

%.PF:                                                                  	
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QDDSSRC) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('/tmp/tmp-122454i9jEWOVC8LM8/BARRYChange/$*.LF') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QDDSSRC.file/$*.mbr') MBROPT(*REPLACE)"
	system $(SYSTEM) "CRTPF FILE($(BIN_LIB)/$*) SRCFILE($(BIN_LIB)/QDDSSRC) SRCMBR($*)"
 
%.FILE: %.LF                                                                                                        
	@echo "*** Creating LF [$*]"                                                                                                                                                                                                                                         
	$(eval crtcmd := $(CRTFRMSTMFLIB)/crtfrmstmf obj($(BIN_LIB)/$*) cmd(CRTLF) srcstmf('./$*.LF') parms('$(CRTLFFLAGS)'))     
	@system -v "$(TOOLSLIB)/EXECWLIBS LIB($(LIBL)) CMD($(crtcmd))"                 

%.rpgle: qrpgsrc/%.rpgle
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QRPGSRC) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('$<') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QRPGSRC.file/$*.mbr') MBROPT(*REPLACE'./$*.LF')"
	liblist -a $(LIBLIST);\
	system $(SYSTEM) "CRTRPGPGM PGM($(BIN_LIB)/$*)"
	
