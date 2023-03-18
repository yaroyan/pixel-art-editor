# base linux image
FROM debian:bullseye-slim

# tauri dependency libs for debian
RUN apt update \
    && apt install -y --no-install-recommends \
    libwebkit2gtk-4.0-dev \
    build-essential \
    curl \
    wget \
    libssl-dev \
    libgtk-3-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev \
    software-properties-common \
    git \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_18.x | sh -
RUN apt install -y --no-install-recommends nodejs

# setup node modules
RUN npm install -g yarn

# install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# setup Rust modules
RUN . $HOME/.cargo/env \
    && rustup component add clippy rls rust-analysis rust-src rust-docs rustfmt rust-analyzer \
    && cargo install cargo-edit cargo-watch