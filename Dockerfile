FROM ubuntu:15.10


MAINTAINER Marc Brugger <github@bakito.ch>
USER root

ENV JAVA_VERSION 8
ENV JAVA_UPDATE 60
ENV JAVA_BUILD 27

ENV JAVA_HOME /opt/java
ENV PATH $JAVA_HOME/bin:$PATH

RUN apt-get update && apt-get install wget tar unzip -y && apt-get clean


RUN echo "$UPDATE"

RUN cd /tmp \
  && wget -q -c -O "jdk.tar.gz" --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" \
  && tar -zxvf jdk.tar.gz > /dev/null \
  && rm /tmp/jdk.tar.gz -Rf \
  && mv /tmp/jdk* /opt \
  && ln -s /opt/jdk* $JAVA_HOME \
  && rm /tmp/* -Rf\
  && wget -q -c -O "jce_policy.zip" --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION}/jce_policy-${JAVA_VERSION}.zip" \
  && unzip jce_policy.zip > /dev/null \
  && mv UnlimitedJCEPolicyJDK8/*.jar $JAVA_HOME/jre/lib/security \
  && rm /tmp/* -Rf
