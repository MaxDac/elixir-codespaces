FROM hexpm/elixir:1.17.3-erlang-27.1-debian-bookworm-20240612-slim AS elixir-build

ENV ERL_HOME="/usr/local/lib/erlang/erts-14.2.2"

RUN apt-get update && apt-get install -y git postgresql-client inotify-tools \
  curl wget gnupg2 dirmngr gpg gawk xz-utils

WORKDIR /tmp

# Installing Node
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
  apt-get install -y nodejs && \
  npm i -g npm

# Installing Zig dependencies
RUN wget https://ziglang.org/download/0.13.0/zig-linux-x86_64-0.13.0.tar.xz && \
  tar -xf zig-linux-x86_64-0.13.0.tar.xz && \
  mv zig-linux-x86_64-0.13.0 /usr/local/lib/ && \
  ln -s /usr/local/lib/zig-linux-x86_64-0.13.0/zig /usr/local/bin/zig && \
  rm -rf zig-linux-x86_64-0.13.0.tar.xz

RUN wget https://github.com/zigtools/zls/releases/download/0.13.0/zls-x86_64-linux.tar.xz && \
  mkdir zls && \
  tar -xf zls-x86_64-linux.tar.xz -C ./zls && \
  mv zls /usr/local/lib/ && \
  chmod +x /usr/local/lib/zls/zls && \
  ln -s /usr/local/lib/zls/zls /usr/local/bin/zls && \
  rm -rf zls-x86_64-linux.tar.gz