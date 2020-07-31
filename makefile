BIN_LIB = BARRYLIB
LIBLIST= $(BIN_LIB) $(BIN_LIB_ILE)
TOOLSLIB = BOBTOOLS

LIB_TARGETS=$(BIN_LIB).lib

PGM_TARGETS=TEST010.RPGLE

PF_TARGETS= TEST01.PF

LF_TARGETS = TEST01A.LF

all: $(LIB_TARGETS) $(PGM_TARGETS) $(PF_TARGETS) $(LF_TARGETS)

%.lib:
	-system -qi "CRTLIB LIB($*)"                                                                      
                                                                                                                     
%.PF:                                                                                                                                                                                                                                                                  
		$(eval crtcmd := $(CRTFRMSTMFLIB)/crtfrmstmf obj($(BIN_LIB)/$*) cmd(CRTPF) srcstmf('$<')   
		@system -v "$(TOOLSLIB)/EXECWLIBS LIB($(BIN_LIB)) CMD($(crtcmd))"
 
%.FILE: %.LF                                                                                                         
	@echo "*** Creating LF [$*]"                                                                                                                                                                                                                                         
	$(eval crtcmd := $(CRTFRMSTMFLIB)/crtfrmstmf obj($(BIN_LIB)/$*) cmd(CRTLF) srcstmf('./$*.PF') parms('$(CRTLFFLAGS)'))     
	@system -v "$(TOOLSLIB)/EXECWLIBS LIB($(LIBL)) CMD($(crtcmd))"                 

%.rpgle:
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QRPGSRC) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('$<') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QRPGSRC.file/$*.mbr') MBROPT(*REPLACE)"
	liblist -a $(LIBLIST);\
	system $(SYSTEM) "CRTRPGPGM PGM($(BIN_LIB)/$*)"
	
