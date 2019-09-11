FROM debian:latest

# might need to install a particular version of perl
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

# create the directories
RUN mkdir /software

# Install infernal
RUN cd /software && \
curl -OL http://eddylab.org/infernal/infernal-1.1.2.tar.gz && \
tar -xvzf infernal-1.1.2.tar.gz && \
cd infernal-1.1.2 && \
./configure && \
make && \
make install && \
cd /software/infernal-1.1.2/easel && \
make install && \
cd miniapps

RUN useradd --create-home -s /bin/bash rfam-user
WORKDIR /home/rfam-user
USER rfam-user

# copy and decompress data files
ADD data/* /home/rfam-user/
RUN rm /home/rfam-user/suspicious_ncRNA_sequences.txt
RUN gunzip /home/rfam-user/ecoli_genome.fa.gz
RUN gunzip /home/rfam-user/Rfam.cm.gz

RUN echo "cd /home/rfam-user" >> ~/.bashrc

# adding infernal tools to your path
ENV PATH=/usr/bin:$PATH:/software/infernal-1.1.2/src:/software/infernal-1.1.2/src/miniapps
