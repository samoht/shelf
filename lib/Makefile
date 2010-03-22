export OCAMLMAKEFILE = ../OCamlMakefile

ANNOTATE = yes

SOURCES = json.ml html.ml pa_shelf.ml
RESULT = shelf
LIBINSTALL_FILES = \
	pa_shelf.o pa_shelf.cmo pa_shelf.cmi \
	json.cmx json.cmo json.cmi json.o \
	html.cmx html.cmo html.cmi html.o

PACKS = dyntype.syntax
USE_CAMLP4 = yes

.PHONY: all
all: bcl ncl
	@ :

.PHONY: java javainstall
java:
	ocamljava -I +camlp4 -I +site-lib/dyntype -c json.mli json.ml html.ml
javainstall:
	cp json.cmj json.jo html.cmj html.jo $(shell ocamlfind printconf path)/shelf/

include $(OCAMLMAKEFILE)
