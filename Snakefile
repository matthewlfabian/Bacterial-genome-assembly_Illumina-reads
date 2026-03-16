# Steps: FastQC & report => trimming via BBDuk => FastQC & report => SPAdes => FastANI/MLSA/BLAST

configfile: "config/config.yaml"

SAMPLES = config["samples"]

include: "rules/FastQC.smk"
include: "rules/MultiQC.smk"
include: "rules/BBDuk.smk"
include: "rules/SPAdes.smk"

rule all:
    input:
    # Stage 1: raw FASTQ QC assessment; comment out when complete
        #expand("FastQC/raw/{sample}_1_fastqc.html", sample=SAMPLES),
        #expand("FastQC/raw/{sample}_2_fastqc.html", sample=SAMPLES),
        #"MultiQC/raw/multiqc_report.html"
    # Stage 2: trimming and trimmed FASTQ QC assessment; uncomment to continue
        expand(config["outdir"] + "/{sample}_1.fastq.gz", sample=SAMPLES),
        expand(config["outdir"] + "/{sample}_2.fastq.gz", sample=SAMPLES),
        expand("FastQC/trimmed/{sample}_1_fastqc.html", sample=SAMPLES),
        expand("FastQC/trimmed/{sample}_2_fastqc.html", sample=SAMPLES),
        "MultiQC/trimmed/multiqc_report.html",
    # Stage 3: assembly and QC assessment; uncomment to continue
        expand("SPAdes/{sample}/scaffolds.fasta", sample=SAMPLES),
        expand("QUAST/{sample}/report.html", sample=SAMPLES),
