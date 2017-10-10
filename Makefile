main : main.tex introduction.tex analysis.tex
	rm -f *.aux *.toc *.lof *.lot
	rm zzz* || true
	latex main || true
	bibtex main
	latex main
	mf -interaction nonstopmode zzzdiagram || true
	mf-nowin -progname=mf '\mode:=localfont; nonstopmode;' input zzzdiagram || true
	bibtex main
	latex main
	latex main
	dvips main.dvi
	ps2pdf main.ps
