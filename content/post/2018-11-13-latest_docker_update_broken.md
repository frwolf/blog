---
title: "docker-ce update is broken on Raspberry Pi Model B Rev 2"
summary: "The latest update of docker-ce to 18.09.0~3-0~raspbian-stretch is broken on Raspberry Pi Model B Rev 2 as containerd refuses to start on this architecture with a core-dump."
date: "2018-11-13"
tags: ["docker", "raspbian", "raspberry_pi"]
_bigimg: [{src: "hugo-static-website-generator.png", desc: "hugo"}]
---

The latest update of `docker-ce` to `18.09.0~3-0~raspbian-stretch` is broken on
Raspberry Pi Model B Rev 2 as `containerd` refuses to start on this architecture
(`armv6l`) with a core-dump.

The workaround is to downgrade the docker version again.

### List the available versions
```
root@raspberrypi:~# apt-cache policy docker-ce
```
```
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

### Downgrade
```
root@raspberrypi:~# apt install docker-ce=18.06.1~ce~3-0~raspbian
```
```
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following package was automatically installed and is no longer required:
  containerd.io
Use 'apt autoremove' to remove it.
[...]
```
### Cleanup
```
root@raspberrypi:~# apt autoremove
```

After that, the docker deamon should be running again.
