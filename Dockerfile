FROM ubuntu:14.04

RUN apt-get -y install software-properties-common
RUN sudo apt-add-repository ppa:synapse-core/testing
RUN apt-get update
RUN apt-get -y install wget git curl xmonad libghc-xmonad-dev libghc-xmonad-contrib-dev xmobar xcompmgr nitrogen stalonetray moreutils consolekit synapse ssh-askpass-gnome thunar terminator remmina


RUN wget -q -O - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | sudo apt-key add - \
 && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
 && apt-get update

RUN apt-get install -y xz-utils file locales dbus-x11 pulseaudio dmz-cursor-theme \
      fonts-dejavu fonts-liberation hicolor-icon-theme google-chrome-stable \
      libcanberra-gtk3-0 libcanberra-gtk-module libcanberra-gtk3-module \
      libasound2 libgtk2.0-0 libdbus-glib-1-2 libxt6 libexif12 \
      libgl1-mesa-glx libgl1-mesa-dri

ADD scripts /scripts
ADD start /start
RUN chmod 755 /start

ADD xmonad /home/anonymous/.xmonad
RUN apt-get -y install xterm


ENTRYPOINT ["/start"]
