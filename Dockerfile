FROM jenkins:latest
MAINTAINER ryu.jiman@gmail.com

USER root

# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables \
    ca-certificates

# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# Define additional metadata for our image.
VOLUME /var/lib/docker

ENV JAVA_ARGS -Xms512m -Xmx1024m

CMD ["/usr/local/bin/wrapdocker"]

ADD jenkins_dind.sh /usr/local/bin/jenkins_dind.sh

RUN chmod +x /usr/local/bin/jenkins_dind.sh

CMD ["/usr/local/bin/jenkins_dind.sh"]