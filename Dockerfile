FROM centos:8
MAINTAINER edimatt
RUN dnf install -y gcc gcc-c++ rpm-build rpmdevtools automake autoconf dnf-plugins-core make cmake flex bison ncurses-devel readline-devel wget sudo python38 python38-rpm-macros python3-rpm-macros
RUN groupadd mockbuild
RUN useradd -g mockbuild mockbuild
RUN echo "mockbuild ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# RUN echo "mockbuild:heartofsteel" | chpasswd
RUN su - mockbuild -c "rpmdev-setuptree"
RUN su - mockbuild -c "sed -e '1i%_build_id_links none' .rpmmacros > .tt; mv .tt .rpmmacros"
# Uncomment the following if you want to be able to install rpms as non root.
# RUN su - mockbuild -c "rpm --dbpath /home/mockbuild/.rpmdb --initdb"
USER mockbuild
WORKDIR /home/mockbuild
CMD /bin/bash
