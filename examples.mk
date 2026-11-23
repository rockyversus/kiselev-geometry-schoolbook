# example rules

.PHONY: examples examples-pdf examples-xe examples-lua \
examples-pdflatex-cm examples-pdflatex-pscyr\
examples-pdflatex-xcharter examples-xelatex-cmu examples-xelatex-msf\
examples-xelatex-liberation examples-lualatex-cmu examples-lualatex-msf\
examples-lualatex-liberation

examples-pdf: examples-pdflatex-cm examples-pdflatex-pscyr \
examples-pdflatex-xcharter

examples-xe: examples-xelatex-cmu examples-xelatex-msf\
examples-xelatex-liberation

examples-lua: examples-lualatex-cmu examples-lualatex-msf\
examples-lualatex-liberation

examples: examples-pdf examples-xe examples-lua

.DISSEXAMPLENAME = dissertation_$(subst -,_,$(subst examples-,,$(TARGET)))$(subst 0,_bibtex,$(subst 1,_biber,$(BIB)))$(subst 0,,$(subst 1,_draft,$(DRF)))

define dissertation-example #Canned Recipe
	$(foreach DRF,0 1, \
	$(foreach BIB,0 1, \
	"$(MAKE)" dissertation \
		BACKEND=$(BACKEND) \
		FONTFAMILY=$(FONTFAMILY) \
		ALTFONT=$(ALTFONT) \
		TARGET=$(.DISSEXAMPLENAME) \
		DRAFTON=$(DRF) \
		USEBIBER=$(BIB); \
	"$(MAKE)" BACKEND=$(BACKEND) TARGET=$(.DISSEXAMPLENAME) \
		SOURCE=dissertation clean-target; \
	))
endef

examples-pdflatex-cm: TARGET=$@
examples-pdflatex-cm: BACKEND=-pdf
examples-pdflatex-cm: ALTFONT=0
examples-pdflatex-cm:
	$(dissertation-example)

examples-pdflatex-pscyr: TARGET=$@
examples-pdflatex-pscyr: BACKEND=-pdf
examples-pdflatex-pscyr: ALTFONT=1
examples-pdflatex-pscyr:
	$(dissertation-example)

examples-pdflatex-xcharter: TARGET=$@
examples-pdflatex-xcharter: BACKEND=-pdf
examples-pdflatex-xcharter: ALTFONT=2
examples-pdflatex-xcharter:
	$(dissertation-example)

examples-xelatex-cmu: TARGET=$@
examples-xelatex-cmu: BACKEND=-pdfxe
examples-xelatex-cmu: FONTFAMILY=0
examples-xelatex-cmu:
	$(dissertation-example)

examples-xelatex-msf: TARGET=$@
examples-xelatex-msf: BACKEND=-pdfxe
examples-xelatex-msf: FONTFAMILY=1
examples-xelatex-msf:
	$(dissertation-example)

examples-xelatex-liberation: TARGET=$@
examples-xelatex-liberation: BACKEND=-pdfxe
examples-xelatex-liberation: FONTFAMILY=2
examples-xelatex-liberation:
	$(dissertation-example)

examples-lualatex-cmu: TARGET=$@
examples-lualatex-cmu: BACKEND=-pdflua
examples-lualatex-cmu: FONTFAMILY=0
examples-lualatex-cmu:
	$(dissertation-example)

examples-lualatex-msf: TARGET=$@
examples-lualatex-msf: BACKEND=-pdflua
examples-lualatex-msf: FONTFAMILY=1
examples-lualatex-msf:
	$(dissertation-example)

examples-lualatex-liberation: TARGET=$@
examples-lualatex-liberation: BACKEND=-pdflua
examples-lualatex-liberation: FONTFAMILY=2
examples-lualatex-liberation:
	$(dissertation-example)
