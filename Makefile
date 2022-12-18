report.pdf: docs/report.tex
	xelatex -file-line-error -interaction=nonstopmode -synctex=1 -output-directory=./ $^
	rm report.pdf
	xelatex -file-line-error -interaction=nonstopmode -synctex=1 -output-directory=./ $^
