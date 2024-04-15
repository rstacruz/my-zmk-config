FROM zmkfirmware/zmk-build-arm:stable
WORKDIR /root
COPY config/west.yml config/west.yml
RUN west init --local config
RUN west update
RUN west zephyr-export
COPY scripts/* scripts/
RUN chmod +x scripts/*
