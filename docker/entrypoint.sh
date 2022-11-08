#!/bin/bash
version=`wget -qO- https://api.github.com/repos/SecorD0/Sui/releases/latest | jq -r ".tag_name"`
if ! sui --version 2&>/dev/null | grep -q $version; then
	wget -qO- "https://github.com/SecorD0/Sui/releases/download/${version}/sui-linux-amd64-${version}.tar.gz" | tar -xzf -
fi
./sui-node "$@"
