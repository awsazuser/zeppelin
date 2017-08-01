FROM apache/zeppelin:0.7.2

# spark
RUN wget https://d3kbcqa49mib13.cloudfront.net/spark-2.1.1-bin-hadoop2.7.tgz
RUN tar -xvzf spark-2.1.1-bin-hadoop2.7.tgz -C /usr/local/
RUN cd /usr/local && ln -s ./spark-2.1.1-bin-hadoop2.7 spark
RUN rm spark-2.1.1-bin-hadoop2.7.tgz

ADD hadoop-azure-2.7.1.jar /usr/local/spark/hadoop-azure-2.7.1.jar
ADD azure-storage-2.0.0.jar /usr/local/spark/azure-storage-2.0.0.jar
ADD sqljdbc4.jar /usr/local/spark/sqljdbc4.jar

ADD core-site.xml /usr/local/spark/conf/core-site.xml
ADD spark-defaults.conf /usr/local/spark/conf/spark-defaults.conf

ENV MASTER spark://spark-master:7077
ENV SPARK_HOME=/usr/local/spark
ENTRYPOINT [ "/usr/bin/tini", "--" ]
WORKDIR ${Z_HOME}
CMD ["bin/zeppelin.sh"]
