SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

MAIN=main
SCORES=$(wildcard in/*.pdf)

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
