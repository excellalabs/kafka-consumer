FROM java:8

RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y ruby-dev ruby \
  && gem install aws-sdk --no-ri --no-rdoc \
  && gem install english --no-ri --no-rdoc
