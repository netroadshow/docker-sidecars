#When using this as a source image, copy out /bin/monit and possibly /etc/monitrc
FROM debian

ENV MONIT_VER 5.25.3

ADD https://mmonit.com/monit/dist/binary/${MONIT_VER}/monit-${MONIT_VER}-linux-x64.tar.gz .
RUN tar -xvzf monit-${MONIT_VER}-linux-x64.tar.gz monit-${MONIT_VER}/bin/monit && \
    mv /monit-${MONIT_VER}/bin/monit /usr/bin/monit && \
    rm -rf monit-${MONIT_VER}/ monit-${MONIT_VER}-linux-x64.tar.gz && \
    mkdir -p /etc/monit.d

ADD monitrc /etc/monitrc
ADD ["monitor.sh", "/sbin/monitor.sh"]
RUN chmod 600 /etc/monitrc

CMD [ "/sbin/monitor.sh" ]
