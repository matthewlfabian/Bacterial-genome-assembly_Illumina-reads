configfile: "config/config.yaml"

SAMPLES = config["samples"]

include: "rules/fastqc.smk"

rule all:
    input:
        expand("results/fastqc/before/{sample}_1_fastqc.html", sample=SAMPLES),
        expand("results/fastqc/before/{sample}_2_fastqc.html", sample=SAMPLES),
        expand("results/fastqc/after/{sample}_1_fastqc.html", sample=SAMPLES),
        expand("results/fastqc/after/{sample}_2_fastqc.html", sample=SAMPLES)
