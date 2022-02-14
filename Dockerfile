FROM gentoo/stage3-amd64:latest
MAINTAINER Jack Mo <mo2231031@live.cn>
ADD src/ /src/
RUN mkdir -p  /opt/opbuild && \
        useradd -d /opt/opbuild -s /bin/bash opbuild && \
    chown -R opbuild:opbuild /opt/opbuild && \
        echo \
app-arch/{bzip2,sharutils,unzip,zip} sys-process/time \
app-text/asciidoc \
dev-libs/{libusb-compat,libxslt,openssl} dev-util/intltool \
dev-vcs/{git,mercurial} net-misc/{rsync,wget} \
sys-apps/util-linux sys-devel/{bc,bin86,dev86} \
sys-libs/{ncurses,zlib} virtual/perl-ExtUtils-MakeMaker \
| sed "s/\s/\n/g" \
| sort \
| tee /etc/portage/sets/openwrt-prerequisites \
&& emerge -DuvNa "@openwrt-prerequisites" && rm -rf /usr/portage/* && \
                        
                       
    chmod +x /src/*

CMD /src/opbuild.sh
