FROM registry.cn-hangzhou.aliyuncs.com/supermonkey_public/java-base:1.1
LABEL maintainer="zhangming@supermonkey.com.cn"

ARG JMETER_VERSION

ENV JMETER_VERSION ${JMETER_VERSION:-5.0}
ENV JMETER_HOME /jmeter/apache-jmeter-$JMETER_VERSION/
ENV PATH $JMETER_HOME/bin:$PATH

# INSTALL PRE-REQ
# RUN apt-get update \
#     && apt-get -y install wget procps unzip openssl sysstat net-tools curl 

# INSTALL JMETER BASE 
RUN mkdir /jmeter
WORKDIR /jmeter

# RUN wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz && \
#     tar -xzf apache-jmeter-$JMETER_VERSION.tgz && \
#     rm apache-jmeter-$JMETER_VERSION.tgz && \
#     mkdir /jmeter-plugins && \
#     cd /jmeter-plugins/ && \
#     wget https://jmeter-plugins.org/downloads/file/JMeterPlugins-ExtrasLibs-1.4.0.zip && \
#     unzip -o JMeterPlugins-ExtrasLibs-1.4.0.zip -d /jmeter/apache-jmeter-$JMETER_VERSION

# 新的 jmeter-plugin安装方式，安装plugin放到 install_plugin-manager-new.sh 脚本里

RUN wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz && \
    tar -xzf apache-jmeter-$JMETER_VERSION.tgz && \
    rm apache-jmeter-$JMETER_VERSION.tgz

# 安装插件 plugins-cmn-jmeter
RUN wget -P  /jmeter/apache-jmeter-$JMETER_VERSION/lib https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-cmn-jmeter/0.6/jmeter-plugins-cmn-jmeter-0.6.jar \
    && wget -P  /jmeter/apache-jmeter-$JMETER_VERSION/lib/ext https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-casutg/2.9/jmeter-plugins-casutg-2.9.jar \
    && wget -P /jmeter/apache-jmeter-$JMETER_VERSION/lib/ext https://repo1.maven.org/maven2/com/blazemeter/jmeter-plugins-random-csv-data-set/0.6/jmeter-plugins-random-csv-data-set-0.6.jar


WORKDIR $JMETER_HOME 

# for slaver    
COPY config/user_new.properties bin/user.properties

COPY scripts/install_plugin-manager-new.sh .
COPY scripts/docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x install_plugin-manager-new.sh /docker-entrypoint.sh
RUN ./install_plugin-manager-new.sh

EXPOSE 6000 1099 50000 4445
ENTRYPOINT ["/docker-entrypoint.sh"]
