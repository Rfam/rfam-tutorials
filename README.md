# Annotating genomes with RNA families using Infernal

This tutorial shows how to use the [Infernal](http://eddylab.org/infernal) software to annotate the reference SARS-CoV-2 genome with RNA families from [Rfam](https://rfam.org).

![SARS-CoV-2 Rfam predictions](https://rfam.org/static/images/coronavirus/sarbecovirus.png)

The same approach can be used to find RNA families in any RNA or DNA sequence.

### Requirements

- [Docker Desktop](https://www.docker.com/products/docker-desktop) on your computer in order to access a complete working environment pre-configured using Docker.

:bulb: Alternatively, try [Play with Docker](https://labs.play-with-docker.com/) (PWD) in your browser (requires a free Docker account and depends on the resource availability).

[![Try in PWD](https://github.com/play-with-docker/stacks/raw/master/assets/images/button.png)](https://labs.play-with-docker.com/)

### Getting started

![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/rfam/tutorials)

Download a pre-built Docker image containing all data and software:

```
docker pull rfam/tutorials
```

Start an interactive session:

```
docker run -it rfam/tutorials
```

You should see a screen similar to the following:

```
$ docker run -it rfam/tutorials
rfam-user@48a963da2278:~$
```

You can now type any [bash commands](https://www.educative.io/blog/bash-shell-command-cheat-sheet) and follow the instructions below.

## Tutorial

1. Type `ls` to list files in your folder. You should see:

    - `Rfam.cm` - Rfam [covariance models](https://docs.rfam.org/en/latest/glossary.html#covariance-model-cm) from release 14.5
    - `Rfam.clanin` - A list of Rfam [clans](https://docs.rfam.org/en/latest/glossary.html#clan)
    - `virus.fasta` - SARS-CoV-2 sequence [NC_045512.2](https://www.ncbi.nlm.nih.gov/nuccore/NC_045512.2)

2. Run `cmpress Rfam.cm` to prepare the Rfam covariance models to be used by Infernal (takes ~15 s, you only need to do this once).

3. Run Infernal `cmscan` to find Rfam families in `virus.fasta` (the command should take 30-60 seconds):

    ```
    cmscan --cut_ga --rfam --nohmmonly --clanin Rfam.clanin --oskip --fmt 2 -o output.txt --tblout table.txt Rfam.cm virus.fasta
    ```

    Here is a quick explanation of the command line options:

    - `--cut_ga` - use the [thresholds](https://docs.rfam.org/en/latest/glossary.html#gathering-cutoff) selected by Rfam curators
    - `--rfam` - run in “fast” mode, the same mode used for Rfam annotation
    - `--nohmmonly` - run all models in CM mode (not HMM mode). This ensures all GA cutoffs, which were determined in CM mode for each model, are valid
    - `--clanin Rfam.clanin --fmt 2 --oskip` - remove redundant hits from the same Rfam clan
    - `-o output.txt` - cmscan output including alignments
    - `--tblout table.txt` - cmscan output table    

    :warning: It is recommended to always use the `--cut_ga --rfam --nohmmonly` options when annotating genomes with Rfam families.

4. Inspect the output files [output.txt](./data/output.txt) and [table.txt](./data/table.txt):

    ```
    less -S output.txt
    less -S table.txt
    ```

5. Find the Rfam families from the Infernal output on the figure from [Huffsky et al., 2020](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7665365/):

    ![SARS-CoV-2 Rfam secondary structure predictions from Huffsky et al., 2020](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7665365/bin/bbaa232f5.jpg)

6.  Bonus points: repeat **step 3** without the `--oskip` option. Notice the additional hits from the bCoV-5UTR and bCoV-3UTR families (see [table-no-oskip.txt](./data/table-no-oskip.txt)).

### Local development

1. Download or clone this repository and move to the directory:
    ```
    git clone https://github.com/Rfam/rfam-tutorials.git
    cd rfam-tutorials
    ```

2. Build a docker image:
    ```
    docker build -t rfam/tutorials .
    ```

3. Start a docker container and mount the data folder:
    ```
    docker run -v `pwd`/data:/home/rfam-user/data -it rfam/tutorials
    ```

### Further reading

- See [Alternate Protocol 1](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6754622/) in _Kalvari et al., 2018_ for more details about annotating a genome with Infernal and Rfam
- Rfam SARS-CoV-2 annotations are described in [Huffsky et al., 2020](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7665365/)
- Find out about other Infernal commands in the [Infernal User Guide](http://eddylab.org/infernal/Userguide.pdf)

### Questions or ideas for improvement?

If you have any feedback, feel free to create an [issue](https://github.com/rfam/rfam-tutorials/issues) or submit a pull request.
