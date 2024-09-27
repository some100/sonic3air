FROM alpine:latest

RUN apk add --update build-base cmake python3

COPY . /src

WORKDIR /src/Oxygen/oxygenserver/build/_cmake/build
RUN /usr/bin/cmake -DCMAKE_BUILD_TYPE=Release .. && /usr/bin/cmake --build . --parallel
RUN wget https://github.com/novnc/websockify/archive/refs/tags/v0.12.0.tar.gz
RUN tar -xvf v0.12.0.tar.gz
WORKDIR /src/Oxygen/oxygenserver/build/_cmake/build/websockify-0.12.0
RUN make

# you still have to expose these ports manually
EXPOSE 21094/udp 
EXPOSE 21095/tcp

ENTRYPOINT [ "/src/Oxygen/oxygenserver/build/_cmake/build/websockify-0.12.0/run", "21095", "--", "/src/Oxygen/oxygenserver/oxygenserver" ]
