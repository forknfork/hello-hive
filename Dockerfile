FROM openjdk:8
RUN apt-get update \
  && apt-get install -y --no-install-recommends ssh \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# sshd
RUN mkdir /run/sshd \
  && ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
  && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
  && chmod 0600 ~/.ssh/authorized_keys

# Hadoop
RUN wget -q -O - http://ftp.tsukuba.wide.ad.jp/software/apache/hadoop/common/hadoop-2.9.2/hadoop-2.9.2.tar.gz | tar zxf -
ENV PATH=/hadoop-2.9.2/bin:/hadoop-2.9.2/sbin:$PATH
COPY config/hadoop /hadoop-2.9.2/etc/hadoop/
RUN hdfs namenode -format

# Hive
RUN wget -q -O - http://ftp.tsukuba.wide.ad.jp/software/apache/hive/hive-2.3.6/apache-hive-2.3.6-bin.tar.gz | tar zxf -
ENV HIVE_HOME=/apache-hive-2.3.6-bin PATH=/apache-hive-2.3.6-bin/bin:$PATH

CMD ["/usr/sbin/sshd"]
