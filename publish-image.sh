#!/bin/sh

docker build -t maxdac/elixir-codespaces:0.1 .
docker login
docker push maxdac/elixir-codespaces:0.1
