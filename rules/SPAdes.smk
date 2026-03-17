# SPAdes genome assembly rule
# --isolate: optimized for isolate genome assembly
# --cov-cutoff off: no coverage cutoff filtering
# -k 23,33,55,77,99: kmer sizes optimized for 100-140bp PE reads
# -t 64: threads
# -m 500: memory limit in GB

rule SPAdes:
    input:
        r1 = config["outdir"] + "/{sample}_1.fastq.gz",
        r2 = config["outdir"] + "/{sample}_2.fastq.gz"
    output:
        "SPAdes/{sample}/scaffolds.fasta"
    threads: 64
    conda: "../envs/SPAdes.yaml"
    shell:
        "spades.py -1 {input.r1} -2 {input.r2} "
        "-o SPAdes/{wildcards.sample} "
        "-k 23,33,55,77,99 "
        "--isolate "
        "--cov-cutoff off "
        "-t {threads} "
        "-m 500"
