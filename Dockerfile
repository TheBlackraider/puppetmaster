FROM blackraider/devenv-base

MAINTAINER blackraider <er.blacky@gmail.com>

USER root

RUN echo "[archlinuxfr]" >> /etc/pacman.conf
RUN echo "SigLevel = Never" >> /etc/pacman.conf
RUN echo "Server = http://repo.archlinux.fr/x86_64" >> /etc/pacman.conf

RUN pacman-key --refresh-keys
RUN pacman -Syu --noconfirm
RUN pacman-db-upgrade

RUN pacman -S --noconfirm yaourt

USER developer

RUN  echo Docker! Docker! | xargs -n 1 | yaourt -S --noconfirm puppetserver 

USER root

RUN puppetserver gem install hiera-eyaml

RUN mkdir -p /etc/puppetlabs/code/environments

ADD puppetserver /etc/default/

EXPOSE 8140

VOLUME /etc/puppetlabs/code/environments



