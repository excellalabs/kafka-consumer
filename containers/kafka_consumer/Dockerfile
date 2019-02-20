FROM java:8

RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y ruby-dev ruby \
  && gem install aws-sdk --no-ri --no-rdoc \
  && gem install english --no-ri --no-rdoc

# Copy up our startup script
COPY run-server.sh /opt/run-server.sh

RUN mkdir -p /opt/kafka-consumer \
  && chmod +x /opt/run-server.sh \
  && chown nobody /opt/kafka-consumer

RUN curl http://central.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.3.1/jmx_prometheus_javaagent-0.3.1.jar > /opt/kafka-consumer/jmx_prometheus_javaagent.jar

COPY prometheus-config.yml /opt/kafka-consumer/prometheus-config.yml

# Poke a hole for the web server
EXPOSE 8090

USER nobody

# Copy application binary to the container
COPY kafka-consumer.jar \
  /opt/kafka-consumer/kafka-consumer.jar

# Start the web server
CMD ["/opt/run-server.sh"]
