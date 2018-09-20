FROM debian:9 as build
# https://github.com/daid/EmptyEpsilon/wiki/Build-from-sources

RUN apt-get update
RUN apt-get install -yqq git build-essential libx11-dev cmake \
  libxrandr-dev mesa-common-dev libglu1-mesa-dev \
  libudev-dev libglew-dev libjpeg-dev libfreetype6-dev \
  libopenal-dev libsndfile1-dev libxcb1-dev \
  libxcb-image0-dev libsfml-dev

RUN git clone https://github.com/daid/SeriousProton.git
RUN git clone https://github.com/daid/EmptyEpsilon.git

RUN mkdir -p /EmptyEpsilon/_build
WORKDIR /EmptyEpsilon/_build/
RUN cmake .. -DSERIOUS_PROTON_DIR=/SeriousProton/
RUN make
RUN make install

# use clean image to not take build sources to final image
FROM debian:9

COPY --from=build /usr/local/bin/EmptyEpsilon /usr/local/bin/
COPY --from=build /usr/local/share/emptyepsilon/ /usr/local/share/emptyepsilon/

# libsfml-dev conveniently install most runtime requirements
RUN apt-get update
RUN apt-get install -yqq libsfml-dev libglu1-mesa

RUN echo "default-server = unix:/run/user/0/pulse/native \n autospawn = no \n daemon-binary = /bin/true \n enable-shm = false" > /etc/pulse/client.conf

ENV UNAME ee

# Set up the user
RUN export UNAME=$UNAME UID=1000 GID=1000 && \
  mkdir -p "/home/${UNAME}" && \
  echo "${UNAME}:x:${UID}:${GID}:${UNAME} User,,,:/home/${UNAME}:/bin/bash" >> /etc/passwd && \
  echo "${UNAME}:x:${UID}:" >> /etc/group && \
  mkdir -p /etc/sudoers.d && \
  echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
  chmod 0440 /etc/sudoers.d/${UNAME} && \
  chown ${UID}:${GID} -R /home/${UNAME} && \
  gpasswd -a ${UNAME} audio

USER $UNAME

ENV DISPLAY :0

ENTRYPOINT ["/usr/local/bin/EmptyEpsilon"]
CMD ["fullscreen=0"]
