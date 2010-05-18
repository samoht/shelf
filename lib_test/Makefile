OCAMLMAKEFILE=../OCamlMakefile
ANNOTATE = yes

.PHONY: run
run: dc
	./$(RESULT) -verbose

PACKS = unix oUnit dyntype.value dyntype.syntax shelf.syntax shelf.json shelf.html
PREDS = camlp4o

RESULT= run_test

TESTS=  test_json_simple test_json test_blog test_html

SOURCES= $(TESTS:%=%.ml) suite.ml

pc_%:
	$(MAKE) -f Makefile.debug $@

p_%:
	$(MAKE) -f Makefile.debug $@

pi_%:
	$(MAKE) -f Makefile.debug $@

i_%:
	$(MAKE) -f Makefile.debug $@

-include $(OCAMLMAKEFILE)
