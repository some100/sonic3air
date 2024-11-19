FROM alpine:latest

RUN apk add --update build-base cmake

COPY . /src

WORKDIR /src/Oxygen/oxygenserver/build/_cmake/build
RUN /usr/bin/cmake -DCMAKE_BUILD_TYPE=Release .. && /usr/bin/cmake --build . --parallel

# you still have to expose these ports manually
EXPOSE 21094/udp 
EXPOSE 21095/tcp

ENTRYPOINT [ "/src/Oxygen/oxygenserver/oxygenserver" ]
