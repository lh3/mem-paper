set ylab "#mapped / total (%)"
set mxtics 10
set mytics 2

set log x;
set format x "10^{%L}"
set yran [84:100]

set pointsize 1.5

set t po eps co enhance "Helvetica,17"

set style line 1 lt 1 pt 1 lc rgb "#FF0000" lw 3;
set style line 2 lt 1 pt 2 lc rgb "#00C000" lw 3;
set style line 3 lt 1 pt 3 lc rgb "#0080FF" lw 3;
set style line 4 lt 1 pt 4 lc rgb "#C000FF" lw 3;
set style line 5 lt 1 pt 5 lc rgb "#00EEEE" lw 3;
set style line 6 lt 1 pt 6 lc rgb "#C04000" lw 3;
set style line 7 lt 1 pt 7 lc rgb "#C8C800" lw 3;
set style line 8 lt 1 pt 8 lc rgb "#FF80FF" lw 3;
set style line 9 lt 1 pt 9 lc rgb "#4E642E" lw 3;
set style line 10 lt 1 pt 10 lc rgb "#800000" lw 3;
set style line 11 lt 1 pt 11 lc rgb "#67B7F7" lw 3;
set style line 12 lt 1 pt 12 lc rgb "#FFC127" lw 3;
set style line 13 lt 1 pt 13 lc rgb "#000000" lw 3;
set style line 14 lt 1 pt 14 lc rgb "#9F0000" lw 3;

set out "alnroc-color-pe.eps"
set key bot right box width -3 font "Helvetica,17"

set xlab "#wrong mappings / #mapped (10^6 {/Symbol \264} 2{/Symbol \264}101bp PE, 1.5% sub, 0.2% indel)"

#set label "star (<135s)" at 0.0015,96.3 front
#set label "gsnap (3514s)" at 0.0008,98.4 front tc rgb "#9F0000"
#"<echo 255 1936412 3793" u ($3/$2):($2/20000) t '' w p ls 13 pt 5, \
#"<echo 255 1955615 2213" u ($3/$2):($2/20000) t '' w p ls 14 pt 5
#"<awk '$3' r12-pe.mem-fast.eval" u ($3/$2):($2/20000) t "mem-fast (286s)" w lp ls 10 lw 2, 
#"<awk '$1>3&&$3' r12-pe.smalt.eval" u ($3/$2):($2/20000) t "smalt (1705s)" w lp ls 10 lw 2,
#"<awk '$3' r12-pe.last.eval" u ($3/$2):($2/20000) t "last (5386s)" w lp ls 8 lw 2

plot "<awk '$3' r12-pe.mem.eval" u ($3/$2):($2/20000) t "bwa-mem (497s)" w lp ls 1 lw 2, \
	 "<awk '$3' r12-pe.gem-bp-e5-s1.eval" u ($3/$2):($2/20000) t "gem (529s)" w lp ls 8 lw 2, \
	 "<awk '$1>1&&$3' r12-pe.bt2.eval" u ($3/$2):($2/20000) t "bowtie2 (545s)" w lp ls 2 lw 2, \
	 "<awk '$3' r12-pe.alto.eval" u ($3/$2):($2/20000) t "seqalto (879s)" w lp ls 12 lw 2, \
	 "<awk '$3' r12-pe.cushaw.eval" u ($3/$2):($2/20000) t "cushaw2 (1026s)" w lp ls 3 lw 2, \
	 "<awk '$3' r12-pe.bwasw.eval" u ($3/$2):($2/20000) t "bwa-sw (1043s)" w lp ls 4 lw 2, \
	 "<awk '$3' r12-pe.bwa.eval" u ($3/$2):($2/20000) t "bwa (1092s)" w lp ls 9 lw 2, \
	 "<awk '$1>3&&$3' r12-pe.novo.eval" u ($3/$2):($2/20000) t "novoalign (2585s)" w lp ls 6 lw 2

set out "alnroc-color-se.eps" 
set key top left font "Helvetica,16" width -3

set xlab "#wrong / #mapped (2{/Symbol \264}10^6 {/Symbol \264} 101bp SE, 1.5% sub, 0.2% indel; correct = within 20bp)"

#set label "star (<128s)" at 0.0015,96.2 front
set xran [1e-7:1e-2]
#set label "star (<128s)" at 0.0015,94.9 front
#set label "gsnap (5553s)" at 0.0013,96.7 front tc rgb "#9F0000"
#"<echo 255 1909382 8711" u ($3/$2):($2/20000) t '' w p ls 13 pt 5, \
#"<echo 255 1922513 5432" u ($3/$2):($2/20000) t '' w p ls 14 pt 5
#"<awk '$3' r12-se.sr.eval" u ($3/$2):($2/20000) t "subread (101s)" w lp ls 11 lw 2, 
#"<awk '$1>3&&$3' r12-se.smalt.eval" u ($3/$2):($2/20000) t "smalt (3859s)" w lp ls 10 lw 2, \
#"<awk '$3' r12-se.last.eval" u ($3/$2):($2/20000) t "last (4302s)" w lp ls 8 lw 2

plot "<awk '$3' r12-se.gem-e5.eval" u ($3/$2):($2/20000) t "gem (426s)" w lp ls 8 lw 2, \
	 "<awk '$3' r12-se.mem.eval" u ($3/$2):($2/20000) t "bwa-mem (467s)" w lp ls 1 lw 2, \
	 "<awk '$1>1&&$3' r12-se.bt2.eval" u ($3/$2):($2/20000) t "bowtie2 (582s)" w lp ls 2 lw 2, \
	 "<awk '$3' r12-se.alto.eval" u ($3/$2):($2/20000) t "seqalto (850s)" w lp ls 12 lw 2, \
	 "<awk '$3' r12-se.cushaw.eval" u ($3/$2):($2/20000) t "cushaw2 (967s)" w lp ls 3 lw 2, \
	 "<awk '$3' r12-se.bwasw.eval" u ($3/$2):($2/20000) t "bwa-sw (1002s)" w lp ls 4 lw 2, \
	 "<awk '$3' r12-se.bwa.eval" u ($3/$2):($2/20000) t "bwa (1055s)" w lp ls 9 lw 2, \
	 "<awk '$1>3&&$3' r12-se.novo.eval" u ($3/$2):($2/20000) t "novoalign (3960s)" w lp ls 6 lw 2
