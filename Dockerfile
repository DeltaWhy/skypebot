FROM ubuntu:trusty
RUN dpkg --add-architecture i386 && apt-get update
RUN apt-get install -y\
    gedit\
    lxde\
    mago\
    openbox\
    qt-at-spi:i386\
    tmux\
    vim\
    wget\
    x11vnc\
    xvfb
RUN wget -q http://download.skype.com/linux/skype-ubuntu-precise_4.3.0.37-1_i386.deb
RUN dpkg -i /skype-ubuntu-precise_4.3.0.37-1_i386.deb;\
    apt-get -f install -y &&\
    dpkg -i /skype-ubuntu-precise_4.3.0.37-1_i386.deb
CMD /skypebot/start.sh
