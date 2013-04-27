.SUFFIXES: .gp .tex .eps .pdf .eps.gz

.eps.pdf:
		epstopdf --outfile $@ $<

.eps.gz.pdf:
		gzip -dc $< | epstopdf --filter > $@

all:bwamem.pdf mem-supp.pdf

bwamem.pdf:bwamem.tex bwamem.bib alnroc-se.pdf alnroc-pe.pdf
		pdflatex bwamem; bibtex bwamem; pdflatex bwamem; pdflatex bwamem;

mem-supp.pdf:mem-supp.tex alnroc-color-se.pdf alnroc-color-pe.pdf
		pdflatex mem-supp; bibtex mem-supp; pdflatex mem-supp; pdflatex mem-supp

alnroc-se.eps alnroc-pe.eps:eval/plot.gp
		(cd eval; gnuplot plot.gp; mv alnroc-se.eps alnroc-pe.eps ..)

alnroc-color-se.eps alnroc-color-pe.eps:eval/plot-color.gp
		(cd eval; gnuplot plot-color.gp; mv alnroc-color-se.eps alnroc-color-pe.eps ..)

clean:
		rm -fr *.toc *.aux *.bbl *.blg *.idx *.log *.out *~ bwamem.pdf alnroc-?e.{eps,pdf}
