FROM ubuntu:22.04

COPY sources.list /etc/apt/

RUN apt-get update
RUN apt-get install -y wget gnupg lsb-release software-properties-common

RUN wget --no-check-certificate -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN add-apt-repository "deb http://apt.llvm.org/$(lsb_release -cs)/   llvm-toolchain-$(lsb_release -cs)-15  main"

RUN apt-get update
RUN apt-get install -y libc++1-15

# dependencies for Agora RTC SDK
RUN apt install -y libxdamage1 libxcomposite-dev libdrm-dev

# Uncomment the following lines to enable profiling
#
# RUN apt update && apt install -y google-perftools
# RUN ln -s /usr/lib/x86_64-linux-gnu/libtcmalloc.so.4 /usr/lib/libtcmalloc.so
# RUN ln -s /usr/lib/x86_64-linux-gnu/libprofiler.so.0 /usr/lib/libprofiler.so

COPY smart_meeting_minutes_go_app /smart_meeting_minutes_go_app

CMD [ "/smart_meeting_minutes_go_app/bin/start" ]
