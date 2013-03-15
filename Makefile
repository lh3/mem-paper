.SUFFIXES: .gp .tex .eps .pdf .eps.gz

.eps.pdf:
		epstopdf --outfile $@ $<

.eps.gz.pdf:
		gzip -dc $< | epstopdf --filter > $@

all:bwamem.pdf

bwamem.pdf:bwamem.tex bwamem.bib alnroc-se.pdf alnroc-pe.pdf
		pdflatex bwamem; bibtex bwamem; pdflatex bwamem; pdflatex bwamem;

alnroc-se.eps alnroc-pe.eps:eval/plot.gp
		(cd eval; gnuplot plot.gp; mv alnroc-se.eps alnroc-pe.eps ..)

clean:
		rm -fr *.toc *.aux *.bbl *.blg *.idx *.log *.out *~ bwamem.pdf alnroc-?e.{eps,pdf}
