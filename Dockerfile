FROM ubuntu:20.04

RUN apt-get update && apt-get install -y apt-transport-https
RUN echo 'deb http://private-repo-1.hortonworks.com/HDP/ubuntu14/2.x/updates/2.4.2.0 HDP main' >> /etc/apt/sources.list.d/HDP.list
RUN echo 'deb http://private-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/ubuntu14 HDP-UTILS main'  >> /etc/apt/sources.list.d/HDP.list
RUN echo 'deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/azurecore/ trusty main' >> /etc/apt/sources.list.d/azure-public-trusty.list


RUN mkdir -p /app/demultiplexed
RUN mkdir -p /app/raw_reads
RUN mkdir -p /app/barcode
COPY ~/raw_reads /app/raw_reads
COPY ~/barcode /app/barcode

RUN git clone https://github.com/grenaud/deML.git  && \
	cd deML.git && \
	make

#CMD ["src/deML -i /app/barcode/barcode.txt -f /app/raw_reads/lane1_R1.fastq.gz - r /app/raw_reads/lane1_R4.fastq.gz -if1 /app/raw_reads/lane1_R2.fastq.gz -if2 /app/raw_reads/lane1_R3.fastq.gz -o /app/demultiplexed."]
