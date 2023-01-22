FROM centos

RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat
RUN curl -O https://downloads.apache.org/tomcat/tomcat-9/v9.0.71/bin/apache-tomcat-9.0.71.tar.gz
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-9.0.71/* /opt/tomcat/.

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum -y install java

RUN yum -y install unzip
RUN yum -y install wget
RUN wget -q https://sourceforge.net/projects/geoserver/files/GeoServer/2.22.0/geoserver-2.22.0-war.zip
RUN unzip -q geoserver-2.22.0-war.zip -d /tmp
RUN mv /tmp/geoserver.war /opt/tomcat/webapps/geoserver.war


EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
