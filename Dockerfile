FROM debian:9
# https://github.com/daid/EmptyEpsilon/wiki/Build-from-sources

RUN apt-get update
RUN apt-get install -yqq git build-essential libx11-dev cmake \
  libxrandr-dev mesa-common-dev libglu1-mesa-dev \
  libudev-dev libglew-dev libjpeg-dev libfreetype6-dev \
  libopenal-dev libsndfile1-dev libxcb1-dev \
  libxcb-image0-dev libsfml-dev

RUN mkdir -p emptyepsilon
WORKDIR emptyepsilon

RUN git clone https://github.com/daid/SeriousProton.git

RUN git clone https://github.com/daid/EmptyEpsilon.git
WORKDIR EmptyEpsilon

RUN mkdir -p _build
WORKDIR _build
RUN cmake .. -DSERIOUS_PROTON_DIR=/emptyepsilon/SeriousProton/
RUN make
RUN make install
WORKDIR /
ENV DISPLAY :0

ENTRYPOINT ["/usr/local/bin/EmptyEpsilon"]
CMD ["fullscreen=0"]
