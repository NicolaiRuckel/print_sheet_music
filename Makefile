SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

MAIN=main
SCORES=$(wildcard in/*.pdf)

# We have to change the name because we will get errors if the tex and pdf
# files have the same name. I don't know why but I don't care enough to look
# into that.
all: out/print_$(SCORES:in/%=%)

out/%.pdf: %.tex
	latexmk $<
	latexmk -c $<

print_%.tex: in/%.pdf
	cp main.tex $@
	sed -i 's/SCORENAME/in\/$(<:in/%=%)/g' $@

clean:
	rm -rf out

.PHONY: all clean
