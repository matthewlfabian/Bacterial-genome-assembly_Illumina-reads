# FastQC quality control rule
# checks raw read quality before trimming
rule fastqc:
    input:
        r1 = "data/{sample}_R1.fastq.gz",
        r2 = "data/{sample}_R2.fastq.gz"
    output:
        "results/fastqc/{sample}_fastqc.html"
    conda: "../envs/fastqc.yaml"
    threads: 2
    shell:
        "fastqc {input.r1} {input.r2} -o results/fastqc/"
