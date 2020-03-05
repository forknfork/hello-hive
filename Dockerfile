FROM openjdk:8
RUN apt-get update \
  && apt-get install -y --no-install-recommends ssh \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN mkdir /run/sshd \
  && ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
  && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
  && chmod 0600 ~/.ssh/authorized_keys
CMD ["/usr/sbin/sshd"]
