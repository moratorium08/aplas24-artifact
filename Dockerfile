FROM moratorium08/hopdr:latest

RUN mkdir /work
WORKDIR /work

COPY clone.sh clone.sh
#COPY check.sh check.sh
COPY get_bench.sh get_bench.sh
RUN ./clone.sh && rm clone.sh && ./get_bench.sh && rm get_bench.sh
COPY scripts ./

ENV PATH="/work/hopdr/hopdr/bin":$PATH

#RUN ./check.sh && rm check.sh

RUN cd /work/hopdr/hopdr && cargo build --release
