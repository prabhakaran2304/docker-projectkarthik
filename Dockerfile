#Pull base image
FROM ubuntu:latest

#Install Apache
RUN apt-get update -y && apt-get install apache2 apache2-utils -y#Define default port
EXPOSE 80
ENTRYPOINT [ "/usr/sbin/apache2ctl" ]#Define default command
CMD [ "-D", "FOREGROUND" ]

# install the OpenJDK 8 java runtime environment and curl
RUN apt install -y default-jre curl wget git nano; \
  apt-get clean

ENV JAVA_HOME /usr
ENV PATH $JAVA_HOME/bin:$PATH

# get maven 3.6.3 and verify its checksum
RUN wget --no-verbose -O /tmp/apache-maven-3.6.3.tar.gz http://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz; \
  echo "87e5cc81bc4ab9b83986b3e77e6b3095 /tmp/apache-maven-3.6.3.tar.gz" | md5sum -c

# install maven
RUN tar xzf /tmp/apache-maven-3.6.3.tar.gz -C /opt/; \
  ln -s /opt/apache-maven-3.6.3 /opt/maven; \
  ln -s /opt/maven/bin/mvn /usr/local/bin; \
  rm -f /tmp/apache-maven-3.6.3.tar.gz
ENV MAVEN_HOME /opt/maven
 
 
