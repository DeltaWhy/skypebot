FROM ubuntu:trusty
RUN apt-get update && apt-get install -y\
    vim\
    wget\
    x11vnc\
    xvfb
RUN wget -q http://download.skype.com/linux/skype-ubuntu-precise_4.3.0.37-1_i386.deb
RUN dpkg --add-architecture i386 && apt-get update
RUN dpkg -i /skype-ubuntu-precise_4.3.0.37-1_i386.deb;\
    apt-get -f install -y &&\
    dpkg -i /skype-ubuntu-precise_4.3.0.37-1_i386.deb
RUN apt-get install -y openbox gedit mago qt-at-spi:i386 tmux
