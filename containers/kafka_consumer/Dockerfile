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

# Poke a hole for the web server
EXPOSE 8090

USER nobody

# Copy application binary to the container
COPY kafka-consumer.jar \
  /opt/kafka-consumer/kafka-consumer.jar

# Start the web server
CMD ["/opt/run-server.sh"]
