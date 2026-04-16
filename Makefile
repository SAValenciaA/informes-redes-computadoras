# Main file
MAIN = main

# Output directory
OUTDIR = build

# LaTeX command
LATEX = latexmk -pdf -interaction=nonstopmode -synctex=1 -outdir=$(OUTDIR)

# Find all .tex files in current directory
TEXTS := $(wildcard *.tex sections/*.tex sections/*/*.tex *.bib)

# Build PDF
$(OUTDIR)/$(MAIN).pdf: $(TEXTS)
	$(LATEX) $(MAIN).tex

# Create output directory if it doesn't exist
$(OUTDIR):
	mkdir -p $(OUTDIR)

.PHONY: all clean rebuild
