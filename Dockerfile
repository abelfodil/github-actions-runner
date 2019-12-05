FROM ubuntu:19.04

RUN apt-get update
RUN yes | apt-get install wget

RUN wget -q https://packages.microsoft.com/config/ubuntu/19.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && dpkg -i packages-microsoft-prod.deb
RUN apt-get update
RUN yes | apt-get install dotnet-runtime-3.0

# Add your packages here

RUN groupadd -r runner && useradd -r -m -g runner runner
USER runner
WORKDIR /home/runner

ENV ARCHIVE_NAME=archive.tar.gz

RUN wget https://githubassets.azureedge.net/runners/2.162.0/actions-runner-linux-x64-2.162.0.tar.gz -q -O $ARCHIVE_NAME
RUN mkdir -p ./actions && tar xzf $ARCHIVE_NAME -C ./actions && rm -f $ARCHIVE_NAME
