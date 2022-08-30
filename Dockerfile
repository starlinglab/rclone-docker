FROM debian:latest

ARG HOST_UID=1001
ARG HOST_GID=1001

RUN apt -y update;\
    apt -y install rclone curl

RUN mkdir /data && \
    groupadd -g $HOST_GID rclone && \
    useradd -ms /bin/bash -u $HOST_UID -g $HOST_GID rclone  && \
    chown $HOST_UID:$HOST_GID /data

COPY rclonesync.sh /rclonesync.sh

USER rclone
WORKDIR /data

ENTRYPOINT ["/bin/bash","/rclonesync.sh"]
