# syntax=docker/dockerfile-upstream:1-labs

FROM docker.io/zmkfirmware/zmk-build-arm:stable

WORKDIR /app

COPY --link base36/west.yml config/west.yml

RUN west init -l config
RUN west update
RUN west zephyr-export

COPY --link bin/build.sh ./

CMD ["./build.sh"]
