FROM debian

RUN apt-get update; apt-get install -y build-essential curl
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs
