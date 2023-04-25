.PHONY: MiCurriculum MiCurriculum-english

CC = xelatex
CURRICULUM_DIR = MiCurriculum MiCurriculum-english
RESUME_DIR_ES = MiCurriculum/cv
RESUME_DIR_EN = MiCurriculum-english/cv
CV_DIR_ES = MiCurriculum/cv
CV_DIR_EN = MiCurriculum-english/cv
RESUME_SRCS_ES = $(shell find $(RESUME_DIR_ES) -name '*.tex')
RESUME_SRCS_EN = $(shell find $(RESUME_DIR_EN) -name '*.tex')
CV_SRCS_ES = $(shell find $(CV_DIR_ES) -name '*.tex')
CV_SRCS_EN = $(shell find $(CV_DIR_EN) -name '*.tex')

MiCurriculum: $(foreach x, Alejandro-Iglesias-Calvo-cv resume coverletter, $x.pdf)

MiCurriculum-english: $(foreach x, Alejandro-Iglesias-Calvo-cv-english resume-english coverletter-english, $x.pdf)

resume.pdf: MiCurriculum/resume.tex $(RESUME_SRCS_ES)
	-$(CC) -interaction=nonstopmode -output-directory=MiCurriculum $<

resume-english.pdf: MiCurriculum-english/resume.tex $(RESUME_SRCS_EN)
	-$(CC) -interaction=nonstopmode -output-directory=MiCurriculum-english $<

Alejandro-Iglesias-Calvo-cv.pdf: MiCurriculum/Alejandro-Iglesias-Calvo-cv.tex $(CV_SRCS_ES)
	-$(CC) -interaction=nonstopmode -output-directory=MiCurriculum $<

Alejandro-Iglesias-Calvo-cv-english.pdf: MiCurriculum-english/Alejandro-Iglesias-Calvo-cv.tex $(CV_SRCS_EN)
	-$(CC) -interaction=nonstopmode -output-directory=MiCurriculum-english $<

coverletter.pdf: MiCurriculum/coverletter.tex
	-$(CC) -interaction=nonstopmode -output-directory=MiCurriculum $<

coverletter-english.pdf: MiCurriculum-english/coverletter.tex
	-$(CC) -interaction=nonstopmode -output-directory=MiCurriculum-english $<

clean:
	rm -rf MiCurriculum/*.pdf
	rm -rf MiCurriculum-english/*.pdf
