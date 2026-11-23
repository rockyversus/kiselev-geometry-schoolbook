# settings precedence: command line>usercfg.mk>{windows,unix}.mk

# user settings
# include before variable definitions
ifneq ($(wildcard usercfg.mk),)
	include usercfg.mk
endif

# platform specific settings
# include before variable definitions
ifeq ($(OS),Windows_NT)
	include windows.mk
else
	include unix.mk
endif

# Ghostscript-based pdf postprocessing
include compress.mk

# Config file
MKRC ?= latexmkrc

# Source .tex file
SOURCE ?= dissertation

# LaTeX compiler output .pdf file
TARGET ?= $(SOURCE)

# LaTeX version:
# -pdf		= pdflatex
# -pdfdvi	= pdflatex with dvi
# -pdfps	= pdflatex with ps
# -pdfxe	= xelatex with dvi (faster than -xelatex)
# -xelatex	= xelatex without dvi
# -pdflua	= lualatex with dvi  (faster than -lualatex)
# -lualatex	= lualatex without dvi
BACKEND ?= -pdf

# Do not modify the section below. Edit usercfg.mk instead.
DRAFTON ?= # 1=on;0=off
SHOWMARKUP ?= # 1=on;0=off
FONTFAMILY ?= # 0=CMU;1=MS fonts;2=Liberation fonts
ALTFONT ?= # 0=Computer Modern;1=pscyr;2=XCharter
USEBIBER ?= # 0=bibtex8;1=biber
IMGCOMPILE ?= # 1=on;0=off
LATEXFLAGS ?= -halt-on-error -file-line-error
LATEXMKFLAGS ?= -silent
BIBERFLAGS ?= # --fixinits
REGEXDIRS ?= . Book # distclean dirs
TIMERON ?= # show CPU usage
TIKZFILE ?= # .tikz file for tikz rule
USEDEV ?= # use development version

# Makefile options
MAKEFLAGS := -s
.DEFAULT_GOAL := all
.NOTPARALLEL:

export DRAFTON
export SHOWMARKUP
export FONTFAMILY
export ALTFONT
export USEBIBER
export IMGCOMPILE
export LATEXFLAGS
export BIBERFLAGS
export REGEXDIRS
export TIMERON
export TIKZFILE
export USEDEV

##! сборка книги
all: dissertation

define compile
	latexmk -norc -r $(MKRC) $(LATEXMKFLAGS) $(BACKEND) -jobname=$(TARGET) $(SOURCE)
endef

##! компиляция книги
dissertation: TARGET=dissertation
dissertation: SOURCE=dissertation
dissertation:
	$(compile)

##! компиляция черновика книги
dissertation-draft: DRAFTON=1
dissertation-draft: dissertation

##! компиляция книги при помощи pdflatex
pdflatex: BACKEND=-pdf
pdflatex: dissertation

##! компиляция черновика книги
draft: dissertation-draft

##! компиляция tikz графики
tikz: SOURCE=tikz
tikz: BACKEND=-pdflua # некоторые библиотеки работают только с lualatex
tikz: TARGET=$(basename $(notdir $(TIKZFILE)))
tikz:
	$(compile)

##! подготовка PDF Книги I для выпуска
release: LATEXMKFLAGS += -interaction=nonstopmode
release: pdflatex
	perl -MFile::Copy=copy -e "copy(shift, shift) or die qq(Could not copy the release PDF\n)" dissertation.pdf kiselev-stereometry-book-1.pdf
	git add -- kiselev-stereometry-book-1.pdf

##! очистка от временных файлов цели TARGET
clean-target:
	latexmk -norc -r $(MKRC) -f $(LATEXMKFLAGS) $(BACKEND) -jobname=$(TARGET) -c $(SOURCE)

##! полная очистка от временных файлов цели TARGET
distclean-target:
	latexmk -norc -r $(MKRC) -f $(LATEXMKFLAGS) $(BACKEND) -jobname=$(TARGET) -C $(SOURCE)

##! очистка проекта от временных файлов
clean:
	"$(MAKE)" SOURCE=dissertation TARGET=dissertation clean-target

##! полная очистка проекта от временных файлов
distclean:
	"$(MAKE)" SOURCE=dissertation TARGET=dissertation distclean-target

# include after "all" rule
include examples.mk

.PHONY: all dissertation dissertation-draft pdflatex draft \
tikz release clean-target distclean-target clean distclean
