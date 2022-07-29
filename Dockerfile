FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN set -e \
      && apt-get -y update \
      && apt-get -y dist-upgrade \
      && apt-get -y install --no-install-recommends --no-install-suggests \
        ca-certificates curl openjdk-8-jre perl unzip \
      && apt-get -y autoremove \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app/demultiplexed
RUN mkdir -p /app/raw_reads
RUN mkdir -p /app/barcode
COPY ~/raw_reads /app/raw_reads
COPY ~/barcode /app/barcode

RUN git clone https://github.com/grenaud/deML.git  && \
	cd deML.git && \
	make

#CMD ["src/deML -i /app/barcode/barcode.txt -f /app/raw_reads/lane1_R1.fastq.gz - r /app/raw_reads/lane1_R4.fastq.gz -if1 /app/raw_reads/lane1_R2.fastq.gz -if2 /app/raw_reads/lane1_R3.fastq.gz -o /app/demultiplexed."]
