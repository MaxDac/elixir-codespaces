FROM hexpm/elixir:1.16.1-erlang-26.2.2-debian-bookworm-20240130-slim AS elixir-build

ENV ERL_HOME="/usr/local/lib/erlang/erts-14.2.2"

RUN apt-get update && apt-get install -y git postgresql-client inotify-tools \
  curl wget gnupg2 dirmngr gpg gawk xz-utils

WORKDIR /tmp

# Installing Node
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
  apt-get install -y nodejs && \
  npm i -g npm

# Installing Zig dependencies
RUN wget https://ziglang.org/download/0.11.0/zig-linux-x86_64-0.11.0.tar.xz && \
  tar -xf zig-linux-x86_64-0.11.0.tar.xz && \
  mv zig-linux-x86_64-0.11.0 /usr/local/lib/ && \
  ln -s /usr/local/lib/zig-linux-x86_64-0.11.0/zig /usr/local/bin/zig && \
  wget https://github.com/zigtools/zls/releases/download/0.11.0/zls-x86_64-linux.tar.gz && \
  mkdir zls && \
  tar -xzf zls-x86_64-linux.tar.gz -C ./zls && \
  mv zls /usr/local/lib/ && \
  chmod +x /usr/local/lib/zls/bin/zls && \
  ln -s /usr/local/lib/zls/bin/zls /usr/local/bin/zls && \
  rm -rf zig-linux-x86_64-0.11.0.tar.xz zls-x86_64-linux.tar.gz

