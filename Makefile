#/*--------------------------------------------------------------------*/
#/*                                                                    */
#/*     Makefile : ロードモジュール作成サンプル                        */
#/*                                                                    */
#/*              Designed by TDST Y.uemura  2003-09-20   Ver. 0.00     */
#/*              Coded    by TDST Y.uemura  2003-09-20   Ver. 0.00     */
#/*              Revised  by                                           */
#/*                                                                    */
#/*     power Dispatch and Transmission Computer Control Designing     */
#/*     Group TOSHIBA FUCHU WORKS.                                     */
#/*                                                                    */
#/*     (C)COPYRIGHT 2003 BY TOSHIBA CORPORATION ALL RIGHTS RESERVED   */
#/*                                                                    */
#/*--------------------------------------------------------------------*/
#CCC            = /usr/local/bin/gcc
CCC             = /home/qden/sousei/my/MT//../../../sbin/gcc
INCLUDE         = -I${DHOME} -I${DWCSHOME}/include -I${PACEHOME}/include
INCLUDE         += -I${OSVDMSWRAP_HOME}/include
CCFLAGS         += -g ${INCLUDE} -D_POSIX_C_SOURCE=199506L -D_XOPEN_SOURCE=500
LIBPATHS        = -L${DHOME}/DSUBM
LIBS            = -lafGiproma -laaCommon -la0Gui -lagGremcastCmmu -laiCmmu
LIBS            += -lDWCSAPI  -losvdmswrap -lm -liconv
LIBS            += -lMW2olv -lMW2date -lMW2bit -lMW2etc
LIBS            += -lsubzsta -lscl
LIBS            += -ldms
## 計算機モード取得
LDFLAGS         += ${LIBPATHS} ${LIBS}
###############################################################################
#
# ソース、c/fortranソース、オブジェクト、ライブラリ ディレクトリ
#
SOCDIR          = ${PWD}
OBJDIR          = ${PWD}
LMFDIR          = $(DHOME)/DAPL
###############################################################################
#
# ロードモジュール?
#
PRGSOC          = DB.c
CMDSOC          =
#
PRGOBJ          = $(PRGSOC:.c=.o)
PRGLMF          = $(PRGSOC:.c=.exe)
PRGNAM          = $(PRGSOC:.c=)
CMDOBJ          = $(CMDSOC:.c=.o)
CMDLMF          = $(CMDSOC:.c=.exe)
CMDNAM          = $(CMDSOC:.c=)
###############################################################################
#
# 暗黙のルール追加
#
#.SUFFIXES:      .c .c~ .c .c~ $(SUFFIXES)
.SUFFIXES:
$(OBJDIR)%.o:$(SOCDIR)%.c
                @echo make object: $(*F).o
                @$(CCC) -c -g $(SOCDIR)/$(*F).c $(CCFLAGS) -o $(OBJDIR)/$(*F).o
$(LMFDIR)%.exe:$(OBJDIR)%.o
                @echo make object: $(*F).exe
                @rm -f $(LMFDIR)/$(*F).exe
                @$(CCC) $(OBJDIR)/$(*F).o -o $(LMFDIR)/$(*F).exe $(CCFLAGS) $(LDFLAGS)
###############################################################################
#
# ガイド表示
#
guide:
                @echo "Usage: make <??姐???・>..."
                @echo "       <??姐???・> all          : 日付?N?・?幻總翫xe8."
                @echo "                clean        : *.exe *.o core 削除"
                @echo "                ?"???五??冖    昇 ～.exe8."
                @echo "                ?"???五??冖小o  : ～.o8."
###############################################################################
# MOD Rev.P64 S yos compile
#all:           $(PRGLMF) $(CMDLMF)
all:            $(LMFDIR)/$(PRGLMF) $(LMFDIR)/$(CMDLMF)
# MOD Rev.P64 E yos compile
###############################################################################
#
#  ロードモジュールファイル8.（プロセス）
#
$(PRGNAM):      $(LMFDIR)/$$@.exe
$(PRGLMF):      $(LMFDIR)/$$@
$(PRGOBJ):      $(OBJDIR)/$$@
###############################################################################
#
#  ロードモジュールファイル8.（コマンド）
#
$(CMDNAM):      $(LMFDIR)/$$@.exe
$(CMDLMF):      $(LMFDIR)/$$@
$(CMDOBJ):      $(OBJDIR)/$$@
###############################################################################
#
# ファイル削除
#
clean:
        -@rm -f $(OBJDIR)/*.o core
# MOD Rev.P64 S yos compile
#       -@rm -f $(LMFDIR)/load*.exe core
        -@rm -f $(LMFDIR)/DB.exe core
# MOD Rev.P64 E yos compile
