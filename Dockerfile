FROM ubuntu:20.04

RUN mkdir -p /home/app/
WORKDIR /home/app
RUN apt-get update 
RUN apt-get update && apt-get install -y \
		wget \
		gawk \
		git \
		tar \
		python3 \
		python3-pip \
		libuv1-dev \
		lsb && \
		apt-get autoclean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/app/demultiplexed
RUN mkdir -p /home/app/raw_reads
RUN mkdir -p /home/app/barcode
COPY ~/raw_reads /home/app/raw_reads
COPY ~/barcode /home/app/barcode

RUN git clone https://github.com/grenaud/deML.git  && \
	cd deML.git && \
	make


#WORKDIR /home/app/deML
#RUN make
#ENV PATH="$PATH:/app/deML/bin/"



CMD ["sh"]
