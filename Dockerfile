FROM nvidia/cuda:11.1-base-ubuntu18.04
WORKDIR /app

ARG PACKAGE_VERSION=5.0.11
ARG BUILD_PACKAGES="wget apt-transport-https"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install foo bar && \ 
		wget \
		gawk \
		git \
		tar \
		python3 \
		python3-pip \
		libuv1-dev \
		lsb && \
		apt-get autoclean && \ rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app/demultiplexed
RUN mkdir -p /app/raw_reads
RUN mkdir -p /app/barcode
COPY ~/raw_reads /app/raw_reads
COPY ~/barcode /app/barcode

RUN git clone https://github.com/grenaud/deML.git  && \
	cd deML.git && \
	make

#CMD ["src/deML -i /app/barcode/barcode.txt -f /app/raw_reads/lane1_R1.fastq.gz - r /app/raw_reads/lane1_R4.fastq.gz -if1 /app/raw_reads/lane1_R2.fastq.gz -if2 /app/raw_reads/lane1_R3.fastq.gz -o /app/demultiplexed."]
