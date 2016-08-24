FROM armhf/alpine:3.3
MAINTAINER Bjoern Petri <bjoern.petri@sundevil.de>

RUN git clone https://github.com/bpetri/sift

ENTRYPOINT ["sift/bin/sift", "sift/filter.file"]
