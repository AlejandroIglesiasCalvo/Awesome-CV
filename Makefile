.PHONY: MiCurriculum

CC = xelatex
CURRICULUM_DIR = MiCurriculum
RESUME_DIR = MiCurriculum/cv
CV_DIR = MiCurriculum/cv
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')
CV_SRCS = $(shell find $(CV_DIR) -name '*.tex')

MiCurriculum: $(foreach x, coverletter Alejandro-Iglesias-Calvo-cv resume, $x.pdf)

resume.pdf: $(CURRICULUM_DIR)/resume.tex $(RESUME_SRCS)
	$(CC) -output-directory=$(CURRICULUM_DIR) $<

Alejandro-Iglesias-Calvo-cv.pdf: $(CURRICULUM_DIR)/Alejandro-Iglesias-Calvo-cv.tex $(CV_SRCS)
	$(CC) -output-directory=$(CURRICULUM_DIR) $<

coverletter.pdf: $(CURRICULUM_DIR)/coverletter.tex
	$(CC) -output-directory=$(CURRICULUM_DIR) $<

clean:
	rm -rf $(CURRICULUM_DIR)/*.pdf
