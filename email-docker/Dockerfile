# Base image
FROM ubuntu:latest
ARG VERSION

# TO be able to modify and edit postfix, opendkim configuration files
# this docker container must run as root.


# Install necessary packages
RUN apt-get update --quiet --quiet \
     && apt-get upgrade --quiet --quiet \
     && echo "postfix postfix/mailname string $hostname" | debconf-set-selections \
     && echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections \
     && echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections \
     && echo "opendmarc opendmarc/dbconfig-install boolean false" | debconf-set-selections \
     && apt-get install -y \
        gettext \
        curl \
        telnet \
        systemd \
        postfix \
        opendkim \
        opendkim-tools \
        opendmarc \
        dovecot-core \
        dovecot-imapd \
        dovecot-pop3d \
        postfix-policyd-spf-python\
        postfix-pcre\
        diceware \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create a mailarchive user
RUN adduser mailarchive --quiet --disabled-password \
    --shell /usr/sbin/nologin --gecos "Mail Archive"


#  entrypoint
USER root
WORKDIR /root


COPY src src/ src/
COPY postfix-init.sh /usr/local/bin/postfix-init.sh

# Set up entrypoint script
RUN chmod +x /usr/local/bin/postfix-init.sh

# Expose ports
EXPOSE 25 587 993

# Set entrypoint
#ENTRYPOINT ["/bin/bash"]
VOLUME ["/var/log", "/var/spool/postfix"]
EXPOSE 25/TCP 587/TCP 993/TCP
ENTRYPOINT ["/usr/local/bin/postfix-init.sh"]
CMD ["postfix", "-v", "start-fg"]