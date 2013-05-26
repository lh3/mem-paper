set ylab "#aligned / total (%)"
set mxtics 10
set mytics 2

set log x;
set format x "10^{%L}"
set yran [84:100]

set pointsize 1.5



set t po eps mono enhance "Helvetica,18"
set out "alnroc-pe.eps"
set key bot right box width -3 font "Helvetica,17"

set xlab "#wrong mappings / #mapped (10^6 {/Symbol \264} 2{/Symbol \264}101bp PE, 1.5% sub, 0.2% indel)"
plot "<awk '$3' r12-pe.mem.eval" u ($3/$2):($2/20000) t "bwa-mem (497s)" w lp ls 1 lw 2, \
	 "<awk '$3' r12-pe.gem-bp-e5-s1.eval" u ($3/$2):($2/20000) t "gem (529s)" w lp ls 7 lw 2, \
	 "<awk '$1>1&&$3' r12-pe.bt2.eval" u ($3/$2):($2/20000) t "bowtie2 (545s)" w lp ls 2 lw 2, \
	 "<awk '$3' r12-pe.cushaw.eval" u ($3/$2):($2/20000) t "cushaw2 (1026s)" w lp ls 3 lw 2, \
	 "<awk '$3' r12-pe.bwasw.eval" u ($3/$2):($2/20000) t "bwa-sw (1043s)" w lp ls 4 lw 2, \
	 "<awk '$3' r12-pe.bwa.eval" u ($3/$2):($2/20000) t "bwa (1092s)" w lp ls 8 lw 2, \
	 "<awk '$1>3&&$3' r12-pe.novo.eval" u ($3/$2):($2/20000) t "novoalign (2585s)" w lp ls 6 lw 2

#	 "<awk '$3' r12-pe.last.eval" u ($3/$2):($2/20000) t "last (5386s)" w lp ls 8 lw 2

set out "alnroc-se.eps" 
set key top left font "Helvetica,17" width -4

set xlab "#wrong mappings / #mapped (2{/Symbol \264}10^6 {/Symbol \264} 101bp SE, 1.5% sub, 0.2% indel)"
plot "<awk '$3' r12-se.gem-e5.eval" u ($3/$2):($2/20000) t "gem (426s)" w lp ls 7 lw 2, \
	 "<awk '$3' r12-se.mem.eval" u ($3/$2):($2/20000) t "bwa-mem (467s)" w lp ls 1 lw 2, \
	 "<awk '$1>1&&$3' r12-se.bt2.eval" u ($3/$2):($2/20000) t "bowtie2 (582s)" w lp ls 2 lw 2, \
	 "<awk '$3' r12-se.cushaw.eval" u ($3/$2):($2/20000) t "cushaw2 (967s)" w lp ls 3 lw 2, \
	 "<awk '$3' r12-se.bwasw.eval" u ($3/$2):($2/20000) t "bwa-sw (1002s)" w lp ls 4 lw 2, \
	 "<awk '$3' r12-se.bwa.eval" u ($3/$2):($2/20000) t "bwa (1055s)" w lp ls 8 lw 2, \
	 "<awk '$1>3&&$3' r12-se.novo.eval" u ($3/$2):($2/20000) t "novoalign (3960s)" w lp ls 6 lw 2

#	 "<awk '$3' r12-se.last.eval" u ($3/$2):($2/20000) t "last (4302s)" w lp ls 8 lw 2



# set t po eps co enhance "Helvetica,16"
# set out "alnroc.eps"
# set key nobox
# 
# set size 1, 0.8
# 
# set style line 1 lt 1 lc rgb "#FF0000" lw 3;
# set style line 2 lt 1 lc rgb "#00C000" lw 3;
# set style line 3 lt 1 lc rgb "#0080FF" lw 3;
# set style line 4 lt 1 lc rgb "#C000FF" lw 3;
# set style line 5 lt 1 lc rgb "#00EEEE" lw 3;
# set style line 6 lt 1 lc rgb "#C04000" lw 3;
# set style line 7 lt 1 lc rgb "#C8C800" lw 3;
# set style line 8 lt 1 lc rgb "#FF80FF" lw 3;
# set style line 9 lt 1 lc rgb "#4E642E" lw 3;
# set style line 10 lt 1 lc rgb "#800000" lw 3;
# set style line 11 lt 1 lc rgb "#67B7F7" lw 3;
# set style line 12 lt 1 lc rgb "#FFC127" lw 3;
# 
# set style line 31 lt 2 lc rgb "#FF0000" lw 3;
# set style line 32 lt 2 lc rgb "#00C000" lw 3;
# set style line 33 lt 2 lc rgb "#0080FF" lw 3;
# set style line 34 lt 2 lc rgb "#C000FF" lw 3;
# set style line 35 lt 2 lc rgb "#00EEEE" lw 3;
# set style line 36 lt 2 lc rgb "#C04000" lw 3;
# set style line 37 lt 2 lc rgb "#C8C800" lw 3;
# set style line 38 lt 2 lc rgb "#FF80FF" lw 3;
# set style line 39 lt 2 lc rgb "#4E642E" lw 3;
# set style line 40 lt 2 lc rgb "#800000" lw 3;
# set style line 41 lt 2 lc rgb "#67B7F7" lw 3;
# set style line 42 lt 2 lc rgb "#FFC127" lw 3;
# 
# set key out vert spac 1.1 wid -7 font "Helvetica,14"
# set xlab "#wrong alignments / #aligned"
# 
# set title "10^6 {/Symbol \264} 2 {/Symbol \264} 101bp reads (1.5% sub; 0.2% indel; solid=PE; dashed=SE)"
# 
# plot "<awk '$3' r12-pe.mem.eval" u ($3/$2):($2/20000) t "bwa-mem (497s)" w l ls 1, \
# 	 "<awk '$1>1&&$3' r12-pe.bt2.eval" u ($3/$2):($2/20000) t "bowtie2 (545s)" w l ls 4, \
# 	 "<awk '$3' r12-pe.cushaw.eval" u ($3/$2):($2/20000) t "cushaw (1026s)" w l ls 7, \
# 	 "<awk '$3' r12-pe.bwasw.eval" u ($3/$2):($2/20000) t "bwa-sw (1043s)" w l ls 2, \
# 	 "<awk '$3' r12-pe.bwa.eval" u ($3/$2):($2/20000) t "bwa (1092s)" w l ls 6, \
# 	 "<awk '$1>3&&$3' r12-pe.novo.eval" u ($3/$2):($2/20000) t "novoalign (2585s)" w l ls 3, \
# 	 "<awk '$3' r12-pe.last.eval" u ($3/$2):($2/20000) t "last (5386s)" w l ls 10, \
# 	 "<awk '$3' r12-se.mem.eval" u ($3/$2):($2/20000) t "bwa-mem (467s)" w l ls 31, \
# 	 "<awk '$3' r12-se.gem-e5.eval" u ($3/$2):($2/20000) t "gem (426s)" w l ls 35, \
# 	 "<awk '$1>1&&$3' r12-se.bt2.eval" u ($3/$2):($2/20000) t "bowtie2 (582s)" w l ls 34, \
# 	 "<awk '$3' r12-se.cushaw.eval" u ($3/$2):($2/20000) t "cushaw (967s)" w l ls 37, \
# 	 "<awk '$3' r12-se.bwasw.eval" u ($3/$2):($2/20000) t "bwa-sw (1002s)" w l ls 32, \
# 	 "<awk '$3' r12-se.bwa.eval" u ($3/$2):($2/20000) t "bwa (1055s)" w l ls 36, \
# 	 "<awk '$1>3&&$3' r12-se.novo.eval" u ($3/$2):($2/20000) t "novoalign (3960s)" w l ls 33, \
# 	 "<awk '$3' r12-se.last.eval" u ($3/$2):($2/20000) t "last (4302s)" w l ls 40
# 
