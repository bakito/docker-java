FROM ubuntu:15.10


MAINTAINER Marc Brugger <github@bakito.ch>
USER root
ENV JAVA_HOME /opt/java
ENV PATH $JAVA_HOME/bin:$PATH


RUN apt-get update && apt-get install wget tar unzip -y


RUN cd /tmp && wget -q -c -O "jdk.tar.gz" --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.tar.gz"

RUN cd /tmp && wget -q -c -O "jce_policy.zip" --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip"


RUN cd /tmp && tar -zxvf jdk.tar.gz > /dev/null


RUN cd /tmp && unzip jce_policy.zip > /dev/null



RUN rm /tmp/jdk.tar.gz -Rf
RUN mv /tmp/jdk* /opt
RUN ln -s /opt/jdk* $JAVA_HOME

RUN cd /tmp/ && mv UnlimitedJCEPolicyJDK8/*.jar $JAVA_HOME/jre/lib/security


RUN rm /tmp/* -Rf
