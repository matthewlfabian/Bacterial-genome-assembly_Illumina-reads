# --min-contig 500: minimum contig length filter
# -r: reference genome for comparative statistics

rule QUAST:
    input:
        scaffolds = "SPAdes/{sample}/scaffolds.fasta",
        reference = config["quast_reference"]
    output:
        "QUAST/{sample}/report.html"
    threads: 8
    conda: "../envs/QUAST.yaml"
    shell:
        "quast.py {input.scaffolds} "
        "-r {input.reference} "
        "--min-contig 500 "
        "-o QUAST/{wildcards.sample}"
