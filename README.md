# 🔮 Google Chrome Browser
A web accessible [google chrome][chrome] browser, using [kasmvnc][kasm]. I don't know why would you use chrome, but its here.

> [!WARNING]
> This repo and package has been deprecated, due to lack of interest. If you need an updated version, you'll need to rebuild the image yourself!

## Setup
To set up the container, you can either use docker-compose or the docker cli. You can also use options and additional settings/mods from linuxserver.io. For updating the container, simply re-pull the image, and deploy it. The [beta][beta_build] version of the browser is also availlable!

### [docker-compose][dcompose] (recommended)
```yaml
---
services:
  chrome:
    image: ghcr.io/tibor309/chrome:latest
    container_name: google-chrome
    security_opt:
      - seccomp:unconfined #optional
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - CHROME_CLI=https://www.github.com/ #optional
    volumes:
      - /path/to/config:/config
    ports:
      - 3000:3000
      - 3001:3001
    shm_size: "1gb"
    restart: unless-stopped
```

### [docker-cli][dcli]
```bash
docker run -d \
  --name=google-chrome \
  --security-opt seccomp=unconfined `#optional` \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e CHROME_CLI=https://www.github.com/ `#optional` \
  -p 3000:3000 \
  -p 3001:3001 \
  -v /path/to/config:/config \
  --shm-size="1gb" \
  --restart unless-stopped \
  ghcr.io/tibor309/chrome:latest
```

## Config
You can also use additional parameters and settings from the [linuxserver/docker-chromium][chromium-setup] project!

| Parameter | Function |
| :----: | --- |
| `-p 3000` | Chrome desktop gui. |
| `-p 3001` | HTTPS chrome desktop gui. |
| `-e PUID=1000` | For UserID |
| `-e PGID=1000` | For GroupID |
| `-e TZ=Etc/UTC` | Specify a timezone to use, see this [list][tz]. |
| `-e CHROME_CLI=https://www.github.com/` | Specify one or multiple [CLI flags][flags], this string will be passed to the application in full. |
| `-v /config` | Users home directory in the container, stores local files and settings |
| `--shm-size=` | This is needed for any modern website to function like youtube. |
| `--security-opt seccomp=unconfined` | For Docker Engine only, many modern gui apps need this to function on older hosts as syscalls are unknown to Docker. |

## Usage
To access the container, navigate to the ip address for your machine with the port you provided at the setup.

* [http://yourhost:3000/][link]
* [https://yourhost:3001/][link]


[beta_build]: https://github.com/tibor309/chrome/tree/beta

[chrome]: https://www.google.com/chrome/
[kasm]: https://kasmweb.com/kasmvnc
[chromium-setup]: https://github.com/linuxserver/docker-chromium/blob/master/README.md#application-setup

[dcompose]: https://docs.linuxserver.io/general/docker-compose
[dcli]: https://docs.docker.com/engine/reference/commandline/cli/
[flags]: https://peter.sh/experiments/chromium-command-line-switches/
[tz]: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List
[link]: https://www.youtube.com/watch?v=dQw4w9WgXcQ
