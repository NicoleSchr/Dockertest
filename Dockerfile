FROM ubuntu:20.04
WORKDIR /app

RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
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

RUN mkdir -p /app/demultiplexed
RUN mkdir -p /app/raw_reads
RUN mkdir -p /app/barcode
COPY ~/raw_reads /app/raw_reads
COPY ~/barcode /app/barcode

RUN git clone https://github.com/grenaud/deML.git  && \
	cd deML.git && \
	make


WORKDIR /app/deML
RUN make
ENV PATH="$PATH:/app/deML/bin/"



CMD ["sh"]
