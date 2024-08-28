FROM moratorium08/hopdr:latest

RUN mkdir /work
WORKDIR /work
COPY clone.sh clone.sh
COPY check.sh clone.sh
RUN ./clone.sh && rm clone.sh

ENV PATH="/work/hopdr/hopdr/bin":$PATH

RUN ./check.sh && rm check.sh


COPY scripts ./
