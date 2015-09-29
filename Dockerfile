FROM rhel7

MAINTAINER Marc Brugger <github@bakito.ch>
USER root
RUN yum install wget tar 

ENV JAVA_VERSION 8
ENV JAVA_UPDATE 60
ENV JAVA_BUILD 27
ENV JAVA_PACKAGE server-jre
#ENV JAVA_PACKAGE jdk

ENV JAVA_HOME /opt/java
ENV PATH $JAVA_HOME/bin:$PATH


RUN cd /tmp \
  && echo "installing $JAVA_PACKAGE"\
  && wget -q -c -O "jdk.tar.gz" --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/$JAVA_PACKAGE-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" \
  && tar -zxvf jdk.tar.gz > /dev/null \
  && rm /tmp/jdk.tar.gz -Rf \
  && mv /tmp/jdk* /opt \
  && ln -s /opt/jdk* $JAVA_HOME \
  && rm /tmp/* -Rf\
  && echo "replacing jce policy"\
  && wget -q -c -O "jce_policy.zip" --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION}/jce_policy-${JAVA_VERSION}.zip" \
  && $JAVA_HOME/bin/jar xvf jce_policy.zip > /dev/null \
  && mv UnlimitedJCEPolicyJDK${JAVA_VERSION}/*.jar $JAVA_HOME/jre/lib/security \
  && rm /tmp/* -Rf\
  && echo "switching to /dev/urandom in $JAVA_HOME/jre/lib/security/java.security"\
  && sed -r -i "s/securerandom\.source=.*/securerandom\.source=file:\/dev\/urandom/g" $JAVA_HOME/jre/lib/security/java.security
