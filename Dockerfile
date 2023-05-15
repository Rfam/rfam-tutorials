FROM debian:latest

RUN apt-get update && apt-get install -y curl \
    gcc \
    git \
    tar \
    unzip \
    perl \
    wget \
    make \
    automake \
    curl \
    gzip \
    g++ \
    vim

RUN mkdir /software

# Install infernal
RUN cd /software && \
    curl -OL http://eddylab.org/infernal/infernal-1.1.4.tar.gz && \
    tar -xvzf infernal-1.1.4.tar.gz && \
    cd infernal-1.1.4 && \
    ./configure && \
    make && \
    make install && \
    cd /software/infernal-1.1.4/easel && \
    make install

RUN useradd --create-home -s /bin/bash rfam-user
WORKDIR /home/rfam-user
USER rfam-user

# Download Rfam data
RUN wget http://ftp.ebi.ac.uk/pub/databases/Rfam/14.9/Rfam.cm.gz && \
    gunzip Rfam.cm.gz && \
    wget http://ftp.ebi.ac.uk/pub/databases/Rfam/14.9/Rfam.clanin

# Download SARS-CoV-2 genome
RUN wget -O virus.fasta "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&rettype=fasta&retmode=text&id=NC_045512.2"

# copy data files
# ADD data/* /home/rfam-user/

COPY bin/tblout2bed.pl /usr/local/bin/tblout2bed.pl

ENV PATH=/usr/bin:$PATH

ENTRYPOINT ["/bin/bash"]
