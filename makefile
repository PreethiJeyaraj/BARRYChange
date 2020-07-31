BIN_LIB = BARRYLIB
LIBLIST= $(BIN_LIB) $(BIN_LIB_ILE)
CRTPFFLAGS = AUT($(AUT)) DLTPCT($(DLTPCT)) OPTION($(OPTION)) REUSEDLT($(REUSEDLT)) SIZE($(SIZE)) TEXT(''$(TEXT)'')      
TOOLSLIB = BOBTOOLS


%.lib:
	-system -qi "CRTLIB $(BIN_LIB)"                                                                                        
                                                                                                                     
%.FILE: %.PF                                                                                                        
		@echo "*** Creating PF [$*]"                                                                                                                                                               
		$(eval crtcmd := $(CRTFRMSTMFLIB)/crtfrmstmf obj($(BIN_LIB)/$*) cmd(CRTPF) srcstmf('$<') parms('$(CRTPFFLAGS)'))     
		@system -v "$(TOOLSLIB)/EXECWLIBS LIB($(LIBL)) CMD($(crtcmd))"
 
%.FILE: %.LF                                                                                                         
	@echo "*** Creating LF [$*]"                                                                                                                                                                                                                                         
	$(eval crtcmd := $(CRTFRMSTMFLIB)/crtfrmstmf obj($(BIN_LIB)/$*) cmd(CRTLF) srcstmf('$<') parms('$(CRTLFFLAGS)'))     
	@system -v "$(TOOLSLIB)/EXECWLIBS LIB($(LIBL)) CMD($(crtcmd))"                 

%.rpgle:
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QRPGSRC) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('$<') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QRPGSRC.file/$*.mbr') MBROPT(*REPLACE)"
	liblist -a $(LIBLIST);\
	system $(SYSTEM) "CRTRPGPGM PGM($(BIN_LIB)/$*)"
	
