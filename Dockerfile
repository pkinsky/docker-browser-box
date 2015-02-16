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
#can skip docker, what I need is docker.io. leaving this here to avoid rebuild
RUN apt-get -y install rxvt-unicode mcrypt docker


RUN adduser dev
RUN echo dev:dev | chpasswd
RUN adduser dev sudo
# RUN mkdir /home/dev && chown -R dev: /home/dev
RUN mkdir -p /home/dev/bin
ENV PATH /home/dev/bin:$PATH
ENV PULSE_SERVER /run/pulse/native
WORKDIR /home/dev
ENV HOME /home/dev

ADD dotfiles/bash_profile /home/dev/.bash_profile
ADD dotfiles/gitconfig /home/dev/.gitconfig


ADD xmonad /home/dev/.xmonad
RUN chmod 777 /home/dev/.xmonad/xmonad.hs

# get sbt via non-repo non-shitty method
# care of https://github.com/paulp/sbt-extras
# todo: put maven cache in shared data dir
RUN curl -s https://raw.githubusercontent.com/paulp/sbt-extras/master/sbt > /home/dev/bin/sbt \
     && chmod 0755 /home/dev/bin/sbt

RUN chown -R dev: /home/dev

ADD start /start
RUN chmod 755 /start

# Create a shared data volume
# We need to create an empty file, otherwise the volume will
# belong to root.
# This is probably a Docker bug.
RUN mkdir /var/shared/
RUN touch /var/shared/placeholder
RUN chown -R dev:dev /var/shared
VOLUME /var/shared


# get spf13 vim config installed
RUN apt-get -y install vim docker.io
RUN curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh


USER dev

ENTRYPOINT ["/start"]


