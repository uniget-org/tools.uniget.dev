---
showDate: false
showShare: false
norss: true
nosearch: true
---

```plaintext
             _            _
 _   _ _ __ (_) __ _  ___| |_
| | | | '_ \| |/ _` |/ _ \ __|
| |_| | | | | | (_| |  __/ |_
 \__,_|_| |_|_|\__, |\___|\__|
               |___/
```

## Purpose

`uniget` is inspired by the [convenience script](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script) to install the Docker daemon. But the scope is much larger.

`uniget` is meant to bootstrap a new box with Docker as well as install useful tools from the container ecosystem and beyond. It can also be used to update these tools. It aims to be distribution-agnostic and provide reasonable default configurations. Personally, I am using it to prepare virtual machines for my own experiments as well as training environments.

Tools are downloaded, installed and updated automatically.

## Installation instructions

```bash
curl -sLf https://github.com/uniget-org/cli/releases/latest/download/uniget_linux_$(uname -m).tar.gz \
| sudo tar -xzC /usr/local/bin uniget
```

## More informaton

The project is [hosted on GitHub](https://github.com/uniget-org). Also checkout the [documentation](https://docs.uniget.dev).

Also checkout the [cheats](https://github.com/uniget-org/cli/blob/main/uniget.cheat) available for [navi](https://github.com/denisidoro/navi). Import them with the following commands:

```
navi repo add https://github.com/uniget-org/cli
```