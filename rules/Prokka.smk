# --proteins: reference FAA collection for annotation priority
# --cpus: threads
# --force: overwrite existing output

rule Prokka:
    input:
        scaffolds = "SPAdes/{sample}/scaffolds.fasta",
        proteins = config["Prokka_proteins"]
    output:
        gff = "Prokka/{sample}/{sample}.gff",
        faa = "Prokka/{sample}/{sample}.faa",
        gbk = "Prokka/{sample}/{sample}.gbk"
    threads: 16
    conda: "../envs/Prokka.yaml"
    shell:
        "prokka --prefix {wildcards.sample} "
        "--cpus {threads} "
        "--proteins {input.proteins} "
        "{input.scaffolds} "
        "--outdir Prokka/{wildcards.sample} "
        "--force"
