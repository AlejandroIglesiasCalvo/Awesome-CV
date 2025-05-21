.PHONY: all clean spanish english

# Output directory for PDFs
OUTPUT_DIR = CVs
TEMP_DIR = .temp

# Create output and temp directories if they don't exist
$(shell mkdir -p $(OUTPUT_DIR) $(TEMP_DIR)/MiCurriculum $(TEMP_DIR)/MiCurriculum-english)

# Compile both Spanish and English versions by default
all: spanish english

# Compile only Spanish version
spanish: $(OUTPUT_DIR)/Alejandro-Iglesias-Calvo-cv.pdf $(OUTPUT_DIR)/resume.pdf $(OUTPUT_DIR)/coverletter.pdf

# Compile only English version (with -eng suffix)
english: $(OUTPUT_DIR)/Alejandro-Iglesias-Calvo-cv-eng.pdf $(OUTPUT_DIR)/resume-eng.pdf $(OUTPUT_DIR)/coverletter-eng.pdf

# Compiler and directories
CC = xelatex
RESUME_DIR_ES = MiCurriculum/cv
RESUME_DIR_EN = MiCurriculum-english/cv
CV_DIR_ES = MiCurriculum/cv
CV_DIR_EN = MiCurriculum-english/cv

# Source files
RESUME_SRCS_ES = $(shell find $(RESUME_DIR_ES) -name '*.tex')
RESUME_SRCS_EN = $(shell find $(RESUME_DIR_EN) -name '*.tex')
CV_SRCS_ES = $(shell find $(CV_DIR_ES) -name '*.tex')
CV_SRCS_EN = $(shell find $(CV_DIR_EN) -name '*.tex')

# Common compiler flags
XELATEX_FLAGS = -interaction=nonstopmode -file-line-error -output-directory

# Spanish version rules
$(OUTPUT_DIR)/resume.pdf: MiCurriculum/resume.tex $(RESUME_SRCS_ES) | $(OUTPUT_DIR)
	-$(CC) $(XELATEX_FLAGS) $(TEMP_DIR)/MiCurriculum $<
	-cp $(TEMP_DIR)/MiCurriculum/resume.pdf $@

$(OUTPUT_DIR)/Alejandro-Iglesias-Calvo-cv.pdf: MiCurriculum/Alejandro-Iglesias-Calvo-cv.tex $(CV_SRCS_ES) | $(OUTPUT_DIR)
	-$(CC) $(XELATEX_FLAGS) $(TEMP_DIR)/MiCurriculum $<
	-cp "$(TEMP_DIR)/MiCurriculum/Alejandro-Iglesias-Calvo-cv.pdf" "$@"

$(OUTPUT_DIR)/coverletter.pdf: MiCurriculum/coverletter.tex | $(OUTPUT_DIR)
	-$(CC) $(XELATEX_FLAGS) $(TEMP_DIR)/MiCurriculum $<
	-cp $(TEMP_DIR)/MiCurriculum/coverletter.pdf $@

# English version rules (with -eng suffix)
$(OUTPUT_DIR)/resume-eng.pdf: MiCurriculum-english/resume.tex $(RESUME_SRCS_EN) | $(OUTPUT_DIR)
	-$(CC) $(XELATEX_FLAGS) $(TEMP_DIR)/MiCurriculum-english $<
	-cp $(TEMP_DIR)/MiCurriculum-english/resume.pdf $@

$(OUTPUT_DIR)/Alejandro-Iglesias-Calvo-cv-eng.pdf: MiCurriculum-english/Alejandro-Iglesias-Calvo-cv.tex $(CV_SRCS_EN) | $(OUTPUT_DIR)
	-$(CC) $(XELATEX_FLAGS) $(TEMP_DIR)/MiCurriculum-english $<
	-cp "$(TEMP_DIR)/MiCurriculum-english/Alejandro-Iglesias-Calvo-cv.pdf" "$@"

$(OUTPUT_DIR)/coverletter-eng.pdf: MiCurriculum-english/coverletter.tex | $(OUTPUT_DIR)
	-$(CC) $(XELATEX_FLAGS) $(TEMP_DIR)/MiCurriculum-english $<
	-cp $(TEMP_DIR)/MiCurriculum-english/coverletter.pdf $@

# Create output directory
$(OUTPUT_DIR):
	@mkdir -p $(OUTPUT_DIR)

# Clean up all generated files
clean:
	rm -rf $(OUTPUT_DIR) $(TEMP_DIR)
	rm -f *.aux *.log *.out *.fls *.fdb_latexmk *.synctex.gz
	rm -f MiCurriculum/*.aux MiCurriculum/*.log MiCurriculum/*.out MiCurriculum/*.fls \
	     MiCurriculum/*.fdb_latexmk MiCurriculum/*.synctex.gz MiCurriculum/*.pdf
	rm -f MiCurriculum-english/*.aux MiCurriculum-english/*.log MiCurriculum-english/*.out \
	     MiCurriculum-english/*.fls MiCurriculum-english/*.fdb_latexmk \
	     MiCurriculum-english/*.synctex.gz MiCurriculum-english/*.pdf