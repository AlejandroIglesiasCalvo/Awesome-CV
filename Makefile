.PHONY: all clean spanish english

# Output directory for PDFs
OUTPUT_DIR = CVs
TEMP_DIR = .temp

# Create output and temp directories if they don't exist
$(shell mkdir -p $(OUTPUT_DIR) $(TEMP_DIR))

# Compile both Spanish and English versions by default
all: spanish english

# Compile only Spanish version
spanish: $(OUTPUT_DIR)/Alejandro-Iglesias-Calvo-cv.pdf $(OUTPUT_DIR)/resume.pdf $(OUTPUT_DIR)/coverletter.pdf

# Compile only English version (with -eng suffix)
english: $(OUTPUT_DIR)/Alejandro-Iglesias-Calvo-cv-eng.pdf $(OUTPUT_DIR)/resume-eng.pdf $(OUTPUT_DIR)/coverletter-eng.pdf

# Compiler and directories
CC = xelatex
CV_DIR = MiCurriculum

# Source files
CV_SRCS_ES = $(shell find $(CV_DIR)/cv -name '*.tex')
CV_SRCS_EN = $(shell find $(CV_DIR)/cv-eng -name '*.tex')

# Common compiler flags
XELATEX_FLAGS = -interaction=nonstopmode -file-line-error -output-directory

# Spanish version rules
$(OUTPUT_DIR)/resume.pdf: $(CV_DIR)/resume.tex $(CV_SRCS_ES) | $(OUTPUT_DIR)
	-cd $(CV_DIR) && $(CC) $(XELATEX_FLAGS) $(CURDIR)/$(TEMP_DIR) resume.tex
	-cp $(TEMP_DIR)/resume.pdf $@

$(OUTPUT_DIR)/Alejandro-Iglesias-Calvo-cv.pdf: $(CV_DIR)/Alejandro-Iglesias-Calvo-cv.tex $(CV_SRCS_ES) | $(OUTPUT_DIR)
	-cd $(CV_DIR) && $(CC) $(XELATEX_FLAGS) $(CURDIR)/$(TEMP_DIR) Alejandro-Iglesias-Calvo-cv.tex
	-cp "$(TEMP_DIR)/Alejandro-Iglesias-Calvo-cv.pdf" "$@"

$(OUTPUT_DIR)/coverletter.pdf: $(CV_DIR)/coverletter.tex | $(OUTPUT_DIR)
	-cd $(CV_DIR) && $(CC) $(XELATEX_FLAGS) $(CURDIR)/$(TEMP_DIR) coverletter.tex
	-cp $(TEMP_DIR)/coverletter.pdf $@

# English version rules (with -eng suffix)
$(OUTPUT_DIR)/resume-eng.pdf: $(CV_DIR)/resume-eng.tex $(CV_SRCS_EN) | $(OUTPUT_DIR)
	-cd $(CV_DIR) && $(CC) $(XELATEX_FLAGS) $(CURDIR)/$(TEMP_DIR) resume-eng.tex
	-cp $(TEMP_DIR)/resume-eng.pdf $@

$(OUTPUT_DIR)/Alejandro-Iglesias-Calvo-cv-eng.pdf: $(CV_DIR)/Alejandro-Iglesias-Calvo-cv-eng.tex $(CV_SRCS_EN) | $(OUTPUT_DIR)
	-cd $(CV_DIR) && $(CC) $(XELATEX_FLAGS) $(CURDIR)/$(TEMP_DIR) Alejandro-Iglesias-Calvo-cv-eng.tex
	-cp "$(TEMP_DIR)/Alejandro-Iglesias-Calvo-cv-eng.pdf" "$@"

$(OUTPUT_DIR)/coverletter-eng.pdf: $(CV_DIR)/coverletter-eng.tex | $(OUTPUT_DIR)
	-cd $(CV_DIR) && $(CC) $(XELATEX_FLAGS) $(CURDIR)/$(TEMP_DIR) coverletter-eng.tex
	-cp $(TEMP_DIR)/coverletter-eng.pdf $@

# Create output directory
$(OUTPUT_DIR):
	@mkdir -p $(OUTPUT_DIR)

# Clean up all generated files
clean:
	rm -rf $(OUTPUT_DIR) $(TEMP_DIR)
	find . -type f \( -name '*.aux' -o -name '*.log' -o -name '*.out' -o -name '*.fls' \
	-o -name '*.fdb_latexmk' -o -name '*.synctex.gz' \) -delete
	rm -f $(CV_DIR)/*.pdf
	@echo "All generated files have been cleaned."