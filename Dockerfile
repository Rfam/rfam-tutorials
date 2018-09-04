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
RUN mkdir /eccb2018 && \
mkdir /software

# copy and decompress data files
ADD data/* /eccb2018/
RUN gunzip /eccb2018/ecoli_genome.fa.gz
RUN gunzip /eccb2018/Rfam.cm.gz

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

# modify bashrc to change to working directory automatically
RUN echo "cd /eccb2018" >> ~/.bashrc

# adding infernal tools to your path
ENV PATH=/usr/bin:$PATH:/software/infernal-1.1.2/src:/software/infernal-1.1.2/src/miniapps
