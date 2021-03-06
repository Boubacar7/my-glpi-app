FROM centos:latest
MAINTAINER Boubacar <ouedraogoboubacar30@gmail.com>

##install GLPI

#ENV http_proxy https://xxx.xxx.xxx.xxx
ENV DEBIAN_FRONTEND noninteractive

#Afin de faciliter l'installation de nouvelles versions de GLPI

ENV GLPI_VERSION=9.2.2
ENV GLPI_URL=https://github.com/glpi-project/glpi/releases/download/$GLPI_VERSION/glpi-$GLPI_VERSION.tgz

WORKDIR /home/

RUN yum update -y && yum upgrade -y \
    && yum install -y httpd \
    && yum install -y wget \
    && yum install -y git \
    && wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    && rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm \
    && yum install yum-utils \
    && yum-config-manager --enable remi-php71 \
    && yum install -y php php-pdo php-cli php-opache php-gd \
        php-imap php-intl php-mbstring php-mcrypt php-mysql \
        php-pear php-pear-MDB2-Driver-mysqli php-xml 

#&& sed 's/memory_limit = 128M/memory_limit = 512M/' /etc/php.ini > /tmp/php.ini \
#&& mv -f /tmp/php.ini /etc/php.ini
 
RUN cd /var/www/html/ && \
    wget ${GLPI_URL} && \
    tar -xvf glpi-${GLPI_VERSION}.tgz && \
    rm -f glpi-${GLPI_VERSION}.tgz

#chmod 777 glpi-${GLPI_VERSION}/files &&  \
#chmod 777 glpi-${GLPI_VERSION}/config && \
  
#si besoin de reconfigurer le fichier de configuration de httpd
#COPY httpd.conf /etc/httpd/conf

EXPOSE 80 443

#start apache
CMD ["/usr/sbin/httpd","-D", "FOREGROUND"]
