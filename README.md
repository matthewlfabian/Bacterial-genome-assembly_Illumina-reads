# Bacterial genome assembly from Illumina reads

A Snakemake workflow for assembly, including FASTQ quality assessment and trimming, for 
bacterial genomes.

# Overview

This pipeline utilizes paired-end Illumina reads as initial input for the
following steps:

- Raw read quality assessment (FastQC, MultiQC)
- Adapter and quality trimming (BBDuk)
- Post-trimming quality assessment (FastQC, MultiQC)
- Genome assembly (SPAdes)
- Assembly quality assessment (QUAST, Prodigal)

Snakemake is a workflow management tool that facilitates organization and 
reproducibility in bioinformatics workflows. Packages are designated via .yaml
files ("envs" directory), and their corresponding parameters are found in .smk files in the "rules"
directory. The "rule all" section of the Snakefile lists target (e.g., trimmed FASTQs, 
scaffold FASTAs) outputs for the workflow, and Snakemake automatically determines which
part(s) of the workflow to run, skipping any step whose output file already exists.

# Dependencies

All dependencies are managed automatically via Conda using the 
environment files in the `envs/` directory.

- FastQC
- MultiQC
- BBDuk
- SPAdes
- QUAST
- Prodigal

# Setup
1.) Clone the repository and activate the Snakemake environment:

  git clone https://github.com/matthewlfabian/Bacterial-genome-assembly_Illumina-reads.git
  conda activate snakemake

2.) Verify the installed repository:

  git remote -v

3.) Edit `config/config.yaml` to include your strain/sample names. For example, for paired-end reads, 
strain/sample names from FASTQ files are identified as follows: <strain_1>_1.fastq.gz, <strain_1>_2.fastq.gz, <strain_2>_2.fastq.gz...

  samples:
    - SAMPLE1
    - SAMPLE2
    - ...

# Running the Pipeline

This pipeline is designed to be run in 3 stages: 1.) initial quality assessment of raw FASTQs; 
2.) FASTQ trimming and quality assessment of trimmed reads; & 3.) genome assembly and quality assessment. 
By utilizing the comment mark (#) in the Snakefile, the workflow can be run stepwise, 
permitting the review of MultiQC reports before and after trimming, before proceeding with genome assembly & 
further analyses. To run the Snakemake workflow on a HPCC:

```bash
snakemake --cores 10 --use-conda
```

At any stage, a "dry run" can be conducted to verify the logic of the workflow:

To preview what Snakemake will run without executing anything:

```bash
snakemake --dry-run --cores 10 --use-conda
```

To visualize the workflow structure via a directed acyclic graph (DAG):

```bash
snakemake --dag | dot -Tpng > docs/dag.png
```


#### Stage 1: Raw read quality assessment
To FastQC and MultiQC on raw reads, then review the MultiQC report 
before proceeding to FASTQ trimming, "comment out" (i.e., add "#") Stages 2 & 3 
in the Snakefile & run Snakemake. Review `MultiQC/raw/multiqc_report.html` 
before continuing.

#### Stage 2: Trimming & trimmed read quality assessment
To proceed with trimming and a subsequent MultiQC report, "uncomment" Stage 2
in the Snakefile & run Snakemake. Review `MultiQC/trimmed/multiqc_report.html` before 
continuing.

#### Stage 3: Assembly & quality assessment
To proceed with assembly & QC, "uncomment" Stage 3 in the Snakefile & run
Snakemake.

# Adjusting parameters
By editing the .smk files for each package in the "rules" subdirectory, parameters can be 
individually adjusted as desired. For example, to adjust k-mer utilization for assembly 
via SPAdes, open SPAdes.smk & edit the "-k" parameter.


# Directory Structure
```
Streptomyces-phylogenetics_common-scab/
├── Snakefile
├── config/
│   └── config.yaml
├── envs/
│   ├── FastQC.yaml
│   ├── MultiQC.yaml
│   └── BBDuk.yaml
├── rules/
│   ├── fastqc.smk
│   ├── MultiQC.smk
│   └── bbduk.smk
├── docs/
│   └── dag.png
└── README.md
```

## Author

Matthew Fabian
[Institution]
[Contact]
