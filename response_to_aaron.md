###An informal response to [Aaron Darling's open review](http://dx.doi.org/10.6084/m9.figshare.714096) on the bwa-mem manuscript

(First of all, I am really grateful to Aaron Darling for his open review. I
concur with him in that open review, at least optional open review, helps to
improve the peer-review system. The following is my response. Part of it is
quite informal, meaning that I would not say it in a formal response, but
sometimes what the authors are really thinking behind the words may be also
interesting.)

####Major comments

> Why does the reseeding approach work? The manuscript does not give any insight
> into why this helps improve accuracy. The issue seems to be that the longest
> matches (the SMEM) for a query sequence might not be part of the true
> alignment. By allowing shorter matches to be alignment seeds it can still find
> the true alignment in the occasional case where the longest MEM matches the
> wrong place. That makes sense, but why require higher multiplicity and
> restrict only to matches covering the middle base in the SMEM? Also, why is
> the reseeding threshold 28nt? I can wager a guess that this seemed like a good
> speed/accuracy tradeoff on a particular dataset but it would be nice to have
> some idea of whether this is a good heuristic for a wide range of datasets or
> if it is really tuned for, e.g. human genomes. Sequence analysis has too many
> magic numbers already. Finally, how frequently is the SMEM not part of the
> true chain in real data? One way to evaluate this would be to test accuracy
> with the reseeding disabled.

As Aaron has noticed, reseeding is to improve accuracy in case the optimal hit
does not contain any SMEMs. Given 100bp simulated reads, about 0.1% of perfect
full-length matches are wrong. If we find SMEMs only, we can only find the
perfect matches and thus we can hardly break the 0.1% mark. When we start to
find short seeds, we will know most of these reads also have many 1-mismatch
hits and assign more proper mapping quality to them.

By searching higher multiplicity covering the middle base of a SMEM, bwa-mem
guarantees to find all seeds no shorter than half of the length of the SMEM. It
is very rare that the optimal mapping contains seeds less than half of SMEMs
(though this still happens). Bwa-mem uses at least 19bp seeds by default. It
does reseeding when the SMEM is longer than 19*1.5. This is where 28bp comes.
It is a heuristic. Mappers that cannot guarantee to find all optimal hits have
something similar.

Bwa-mem can be tuned to only reseed when the optimal hit is a perfect match
(option -r100). In this mode, it is about 80% faster than the default (i.e.
nearly halved run time). The single-end accuracy is obviously lower. The
paired-end is a little lower.

> How does the seed ranking work? The manuscript says "We rank a seed by length
> of chain it belongs to and then by the seed length" but this plain language
> description lacks the precision required to reproduce the method. Is chain
> length defined as the span of the chain in the query, the reference sequence,
> the sum of constituent seed lengths or something else? This should be
> explained.

The length of a chain is the span on the read or on the reference, whichever is
shorter. For the vast majority of reads, seeds are non-overlapping on both the
read and the reference. (Informal note: chaining has more "magic numbers" about
how long to chain. These numbers have little effect on speed/accuracy, but we
have to make an arbitrary choice.)

> The program evaluation is quite limited, in that only a single substitution &
> indel rate is used to compare aligners. Comparing a wide range of sequence
> divergences is a pretty substantial computational undertaking so itâ€™s ok
> to keep the benchmarking simple, but the interpretation of results needs to
> be strongly qualified in the manuscript. I am specifically concerned that the
> SMEM based alignment seeding strategy will fall apart at higher substitution
> or indel error rates because it depends on finding long exact matches. What
> happens to reads with dense polymorphisms or sequencing data generated on
> instruments with high error rates such as the Pacific Biosciences instrument?

The rate of mis-seeding is determined by the chance of finding a 19bp exact
seed on a read. Even if the error rate reaches 10%, there will still be a very
high chance to see a 19bp seed given a 1000bp read. The simulated data set uses
high error rate and evenly distributed errors. It is already harder than
typical human resequencing data. On real Illumina human data, the bwa-mem
seeding should be an even less concern.

I have not tried bwa-mem on PacBio reads, and I doubt it will perform well.
Bwa-mem is not designed with PacBio in mind. Bwa-sw may be more accurate on
PacBio data.

> There is one glaring omission in the comparison set of aligners and that is
> [LAST](http://last.cbrc.jp). LAST can do some clever things such as
> qualityÂ­aware gapped alignment scoring and approximate Bayesian aligned read
> pairing, in addition to long sequence alignment. If there is some reason that
> a comparison to LAST isn't possible or appropriate it should be stated so
> rather than leaving us to wonder about it.

I have tested LAST before the submission. You can find the timing and the
evaluation [here](https://github.com/lh3/mem-paper/tree/master/eval). In
general, LAST is compared favorably to others, but it is less accurate than
bwa-mem on my data set. The key reason that I have not included in the ROC-like
plot is its questionable implementation. LAST itself is reasonably fast.
However, it generates a huge MAF file (for bacteria, this is not a problem) and
its MAF-to-SAM generator is slower than alignment. If LAST were able to output
the final SAM directly, I would recommend it and include it in the plot. Right
now, it is a good mapper for bacteria, but not for mammals.

(As an informal note, when I review manuscripts on NGS mappers, I almost never
ask the authors to include additional mappers; when I do raise a request, I
usually mark it as a minor/optional comment. Having a couple of more mappers of
similar functionality helps little on the overall quality of such manuscripts
except satisfying my own curiosity. As to this Application Note, it already
evaluates more mappers than most other papers on NGS mapping.)

####Minor comments

> There are numerous minor grammatical and spelling errors which could be
> easily fixed and would improve readability.

I would love to fix these grammatical errors.

> There seems to be a single mismatch penalty used for the gapped alignment,
> however, some nucleotide substitutions happen much more frequently than
> others. At a minimum the ability to treat transitions differently than
> transversions would be nice, though being able to use a 4x4 substitution
> matrix (and/or estimating it directly from the data) would be ideal.

For typical resequencing projects, especially for human resequencing, the
sequencing error rate is much higher than the rate of variations. It is not
necessary to distinguish transitions and transversions. For cross-species
alignment where variations are frequent, I agree specifying a scoring matrix is
preferred. But even in that case, it will have little effect on mapping
accuracy (more on alignment accuracy).

> No mention is made of whether or how the perÂ­base quality estimates produced
> by sequencing instruments are used during gapped alignment.

Base quality is not used because base quality is frequently inaccurate and it
does not seem to bring a substantial improvement on accuracy. More importantly,
mismappings caused by sequencing errors tend not to be recurrent; mismappings
caused by variants tend to be recurrent, but considering base quality does not
help. Only recurrent mismappings have impact on downstream analyses.

> The value of the "SW rescuing" approach is unclear. The manuscript says the
> 2nd best SW score is recorded Â­Â­ what happens when there are many equally
> good alignments? The alignment with the 2nd best score might be minimally
> different. Or is this referring to the best alignment to a different region
> of the reference sequence? If so, the explanation needs to be improved.

SW is applied to a small window only, typically a few hundred bp. The 2nd best
score is the suboptimal score in this window. It helps to identify local tandem
repeats.

> What is a "standing seed" in section 3 paragraph 2?

Seeds that are likely to be on the optimal alignments.

> The discussion comment that "only bwa mem scales well to large genomes" is
> misleading since there is a well developed body of literature on methods and
> software for pairwise and multiple genome alignment covering large genomes
> and some of them scale very well to large genomes. bwa mem and nucmer are not
> the only two programs in this space.

The full sentence is "Note that although nucmer is faster in the evaluation,
only BWA-MEM scales well to large genomes". It is a little clearer that we are
comparing nucmer and bwa-mem here. Nonetheless, I agree it would be good to
clarify.

####Other comments

> The description of how pairing scores are calculated was pleasantly
> understandable (to me, anyway) and succinct. One question: if each read in a
> pair has many possible alignment locations then a large number of possible
> combinations arise. Are all of these scored or does bwa bound the search
> somehow?

As I understand, LAST essentially takes this approach for pairing, too. When
pairing, bwa-mem sorts all hits from both ends together. It then does a linear
scan over the list with a window whose size is determined by the insert size
distribution. It is not necessary to inspect all pairs.

> "is more performant" ­> performs better

It will be changed.

####Review of the software

> ...<br> accuracy was evaluated using a short perl script (see file
> bwa\_mem\_eval.tar.bz2 in figshare):
>
>> ./accuracy.pl cbot\_mem.sam < cbot\_mem.both.aln<br> precision:
>> 0.992127563556135 recall: 0.998284561049445<br> ./accuracy.pl
>> lastal\_pairs.sam < cbot\_mem.both.aln<br> precision: 1 recall:
>> 0.988837162737148<br>
> 
>
> So lastal has remarkably good precision but aligns slightly fewer of the
> reads with the recommended settings than bwa mem. If we turn these numbers
> into an F1 score (http://en.wikipedia.org/wiki/F1_score)
> we get lastal: 0.98883 bwa­mem: 0.99519 so if you like the balance of
> precision and recall provided by F1, bwa­mem seems like a good choice. For
> things like identifying rare variants, I will probably stick with lastal when
> possible since the occasional misalignments could potentially end up creating a
> lot of rare variants. It might also be possible to improve lastal's recall
> with a lower e­value threshold, I did not explore this.

This evaluation has a flaw: it includes mapQ=0 mappings from bwa-mem but not
from LAST (because LAST does not report them by default). Most mapQ=0 mapping
are wrong. A better way is:

	./accuracy.pl <(awk '/^@/||$5>=5' cbot_mem.sam) < cbot_mem.both.aln
	precision: 0.99987314474185	recall: 0.986507797441738
	./accuracy.pl <(awk '/^@/||$5>=30' cbot_mem.sam) < cbot_mem.both.aln
	precision: 1	recall: 0.983455974370526

At threshold mapQ=5, bwa-mem gives 5 mismapping, including two pairs and one
end, all with mapQ<30. For one pair, bwa-mem chooses the position with fewer
mismatches. For the other pair, bwa-mem clips the alignment because there are
excessive mismatches (~7 in 33bp). If we reduce the mismatch penalty (e.g. with
-B2), the simulated position will be recovered. The single end mismapping is
also caused by excessive mismatches (18 mismatches in 100bp). Bwa-mem could not
find a 19bp seed. Reducing seed length helps to recover the simulated position.

In all, LAST indeed performs better on this data set, but only marginally.
Bwa-mem gives 5 mismappings at Q5 because 1) the simulated sequencing error
rate is very high, about 8.5% according to the LAST alignment, with errors
about evenly distributed along reads. Using shorter seeds and smaller mismatch
penalty is preferred. 2) LAST makes use of base quality. I speculate that it
does not report the first mismapped pair because critical mismatches are on low
quality bases. In practice, mismappings caused by sequencing errors tend not to
recur. Such mismappings usually do not lead to false variant calls.

Furthermore, on my data set, bwa-mem is the more accurate. For the most
reliable 180k mappings, bwa-mem makes no mistakes, while LAST gives 105
mismappings; at 195k, bwa-mem reports 182 mismappings, while LAST 7802
(novoalign 63).

(I really appreciate that Aaron has evaluated bwa-mem by himself. In my view,
if a reviewer wants to reject a manuscript on mappers/assemblers or to give
very negative reviews, he/she should at least try the tool to make sure the
negative words fully justified. It only takes hours to reject a manuscript
written in months. Comments leading to a rejection need to be taken seriously.
Unfortunately, very few reviewers run tools nowadays. Admittedly, even I have
given very negative reviews once or twice without running the tools.)
