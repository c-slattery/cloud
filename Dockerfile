# the free version of a/kdb+ is 32-bit, install 32-bit libraries
# unzip is needed to install q/kdb+
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get -y install libc6:i386 \
                       libncurses5:i386 \
                       rlwrap \
                       libstdc++6:i386 \
                       unzip
# install q/kdb+, download the zip file for linux from kx.com/download
ADD linux.zip /opt/
RUN cd /opt && unzip linux.zip && echo "" > /opt/q/q.q
RUN useradd -ms /bin/bash kdb
USER kdb
WORKDIR /home/kdb
# set up some paths for q/kdb+
ENV QHOME=/opt/q QARCH=l32 Q=/opt/q/l32/q
RUN echo "alias q=\"rlwrap \$QHOME/\$QARCH/q\"" >> ~/.bashrc
