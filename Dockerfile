FROM alpine:3.5

ADD ./ /go/src/github.com/blazent2/nsqd-prometheus-exporter

WORKDIR /go/src/github.com/blazent2/nsqd-prometheus-exporter

# Using go >= 1.6
RUN echo http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    apk update && \
    apk add -U build-base file go git bash curl libstdc++ && \
    cd /go/src/github.com/blazent2/nsqd-prometheus-exporter && \
    make && \
    apk del build-base go file git

EXPOSE 30000

CMD /go/src/github.com/blazent2/nsqd-prometheus-exporter/nsqd-prometheus-exporter run
