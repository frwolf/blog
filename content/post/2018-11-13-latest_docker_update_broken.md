---
title: "How to fix broken docker-ce update on Raspberry Pi Model B Rev 2"
summary: "The latest update of `docker-ce` to `18.09.0~3-0~raspbian-stretch` on `raspbian-stretch` is broken for the Raspberry Pi Model B Rev 2 as `containerd` refuses to start on this architecture (`armv6l`) with a core-dump."
date: "2018-11-13"
tags: ["docker", "raspbian", "raspberry_pi"]
_bigimg: [{src: "hugo-static-website-generator.png", desc: "hugo"}]
---

The latest update of `docker-ce` to `18.09.0~3-0~raspbian-stretch` on `raspbian-stretch`
is broken for the Raspberry Pi Model B Rev 2 as `containerd` refuses to start on this
architecture (`armv6l`) with a core-dump.

With the following command you can print out your model and the machine architecture
```sh
$ echo $(tr -d '\0' < /proc/device-tree/model) - $(uname -m)
```

The workaround is to downgrade the docker version to a known good version.

#### List the available versions
```sh
$ sudo apt-cache policy docker-ce
```
```sh
docker-ce:
  Installed: 5:18.09.0~3-0~raspbian-stretch
  Candidate: 5:18.09.0~3-0~raspbian-stretch
  Version table:
 *** 5:18.09.0~3-0~raspbian-stretch 500
        500 https://download.docker.com/linux/raspbian stretch/edge armhf Packages
        100 /var/lib/dpkg/status
     18.06.1~ce~3-0~raspbian 500
        500 https://download.docker.com/linux/raspbian stretch/edge armhf Packages
     18.06.0~ce~3-0~raspbian 500
        500 https://download.docker.com/linux/raspbian stretch/edge armhf Packages
[...]
```

#### Downgrade to the last working version
```sh
$ sudo apt install docker-ce=18.06.1~ce~3-0~raspbian
```
```sh
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following package was automatically installed and is no longer required:
  containerd.io
Use 'apt autoremove' to remove it.
[...]
```
#### Prevent docker-ce from updating
```sh
$ sudo apt-mark hold docker-ce
```

#### Cleanup the no longer required packages
```sh
$ sudo apt autoremove
```

After that, the docker deamon should be running again.
