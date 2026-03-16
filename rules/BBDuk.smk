# qtrim=r: trim low quality bases from right
# trimq=15: minimum quality score
# ftm=5: trim to length divisible by 5
# minlength=100: discard reads shorter than 100bp
# ftl=10: trim first 10 bases from left (random hexamer priming bias)
# trimpolygright=5: trim poly-G runs from right (NovaSeq two-color chemistry artifact)

rule BBDuk:
    input:
        r1 = "FASTQ/raw/{sample}_1.fastq.gz",
        r2 = "FASTQ/raw/{sample}_2.fastq.gz"
    output:
        r1 = "FASTQ/trimmed/{sample}_1.fastq.gz",
        r2 = "FASTQ/trimmed/{sample}_2.fastq.gz"
    conda: "../envs/BBDuk.yaml"
    shell:
        "bbduk.sh in1={input.r1} in2={input.r2} "
        "out1={output.r1} out2={output.r2} "
        "qtrim=r trimq=15 ftm=5 minlength=100 ftl=10 trimpolygright=5"
