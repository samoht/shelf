export OCAMLMAKEFILE = ../OCamlMakefile

ANNOTATE = yes

SOURCES = json.ml html.ml pa_shelve.ml
RESULT = pa_shelve
LIBINSTALL_FILES = \
	pa_shelve.a pa_shelve.o pa_shelve.cma pa_shelve.cmi pa_shelve.cmo pa_shelve.cmx pa_shelve.cmxa \
	json.cmx json.cmo json.cmx \
	html.cmx html.cmo html.cmx

PACKS = dyntype.syntax
USE_CAMLP4 = yes

.PHONY: all
all: bcl ncl
	@ :

include $(OCAMLMAKEFILE)
