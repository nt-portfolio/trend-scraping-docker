###########################################################################
# Image Setup
###########################################################################
ARG ARGS_PHP_VERSION
FROM php:${ARGS_PHP_VERSION}-apache

ARG ARGS_MAINTAINER
LABEL maintainer ${ARGS_MAINTAINER}

###########################################################################
# Set Timezone
###########################################################################
ARG ARGS_TZ
RUN ln -snf /usr/share/zoneinfo/${ARGS_TZ} /etc/localtime && echo ${ARGS_TZ} > /etc/timezone

###########################################################################
# User bashrc
###########################################################################
COPY ./web/file/shell/bashrc.sh /root/bashrc.sh

RUN sed -i 's/\r//' /root/bashrc.sh && \
    echo "" >> /root/.bashrc && \
    echo "# Load Custom bashrc" >> /root/.bashrc && \
    echo "source ~/bashrc.sh" >> /root/.bashrc && \
    echo "" >> /root/.bashrc

###########################################################################
# Package update
###########################################################################
RUN set -xe; \
    apt-get update -yqq

###########################################################################
# Package install
###########################################################################
RUN apt install -y --no-install-recommends \
    apt-utils \
    gawk \
    rsyslog \
    procps \
    cron \
    # for GD
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libxpm-dev \
    # oniguruma (for php 7.4)
    libonig-dev \
    # libxml2 (for php 7.4)
    libxml2-dev \
    # ssl
    openssl ssl-cert libssl-dev \
    # other
    unzip wget gettext libcurl4-gnutls-dev libexpat1-dev libz-dev libpcre3-dev bison g++ \
    # Autotools
    autoconf automake libtool \
    # docker-php-ext-install
    && docker-php-ext-install \
    gd mbstring xmlrpc

#--------------------------------
# Git
#--------------------------------
ARG ARGS_INSTALL_GIT
RUN if [ ${ARGS_INSTALL_GIT} = true ]; then \
    apt install -y --no-install-recommends \
    git-all \
;fi

#--------------------------------
# xDebug
#--------------------------------
ARG ARGS_INSTALL_XDEBUG
RUN if [ ${ARGS_INSTALL_XDEBUG} = true ]; then \
    pecl install xdebug \
    && docker-php-ext-enable xdebug \
;fi

#--------------------------------
# composer
#--------------------------------
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

#--------------------------------
# vim
#--------------------------------
RUN apt install -y --no-install-recommends vim
COPY ./web/file/shell/create_vimrc.sh /tmp/
RUN /bin/bash -c "source /tmp/create_vimrc.sh"

###########################################################################
# File copy
###########################################################################

# php.ini
COPY ./web/file/php/php.ini /usr/local/etc/php/

#apache conf
COPY ./web/file/apache2/apache2.conf /etc/apache2/apache2.conf
COPY ./web/file/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
COPY ./web/file/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf

# ssl
COPY ./web/file/shell/dummy_ssl.sh /tmp/
RUN mkdir -p /etc/pki/tls \
    && chmod a+x /tmp/dummy_ssl.sh \
    && /bin/bash -c "source /tmp/dummy_ssl.sh" \
    && a2enmod rewrite \
    && a2enmod ssl \
    && a2ensite 000-default \
    && a2ensite default-ssl

###########################################################################
# Final touch
###########################################################################
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && apt autoremove
