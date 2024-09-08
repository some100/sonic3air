FROM debian:latest

WORKDIR /

RUN apt-get update && apt-get install -y build-essential cmake

COPY . /src

WORKDIR /src/Oxygen/oxygenserver/build/_cmake/build
RUN /usr/bin/cmake -DCMAKE_BUILD_TYPE=Release .. && /usr/bin/cmake --build . --parallel

EXPOSE 21094/udp 
EXPOSE 21095/tcp
ENTRYPOINT [ "/src/Oxygen/oxygenserver/oxygenserver" ]
