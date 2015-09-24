FROM ubuntu:15.10


MAINTAINER Marc Brugger <github@bakito.ch>
USER root
ENV JAVA_HOME /opt/java
ENV PATH $JAVA_HOME/bin:$PATH


RUN apt-get update && apt-get install wget tar unzip -y


RUN cd /tmp && wget -q -c -O "jdk.tar.gz" --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.tar.gz" \
  && tar -zxvf jdk.tar.gz > /dev/null \
  && rm /tmp/jdk.tar.gz -Rf \
  && mv /tmp/jdk* /opt \
  && ln -s /opt/jdk* $JAVA_HOME \
  && cd /tmp \
  && wget -q -c -O "jce_policy.zip" --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip" \
  && unzip jce_policy.zip > /dev/null \
  && mv UnlimitedJCEPolicyJDK8/*.jar $JAVA_HOME/jre/lib/security \
  && rm /tmp/* -Rf
