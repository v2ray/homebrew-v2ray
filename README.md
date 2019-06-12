### homebrew v2ray  [![Build Status](https://travis-ci.org/v2ray/homebrew-v2ray.svg?branch=master)](https://travis-ci.org/v2ray/homebrew-v2ray)


The homebrew tap for v2ray-core.


------


### Install v2ray-core


step 1: Add official tap

```bash
brew tap v2ray/v2ray
```

step 2: Install v2ray-core:

```bash
brew install v2ray-core
```

### Update v2ray-core

step 1: update tap

```bash
brew update
```

step 2: update v2ray-core

```bash
brew upgrade v2ray-core
```

------

### Uninstall v2ray-core

step 1: uninstall core

```bash
brew uninstall v2ray-core
```

step 2: untap official formula

```bash
brew untap v2ray/v2ray
```

------

### Usage

once you installed, you can run command via `v2ray` to run v2ray-core.

The defualt config file location is:`/usr/local/etc/v2ray/config.json`

step 1: edit the default config:

```bash
vim /usr/local/etc/v2ray/config.json
```

step 2: run v2ray-core without starting at login.

```bash
brew services run v2ray-core
```

or run v2ray-core and register it to launch at login via:

```bash
brew services start v2ray-core
```

to specify your own configuration file, please use `V2RAY_CONFIG` environment variable:

```bash
launchctl setenv V2RAY_CONFIG <CONFIG_FILE>
brew services restart v2ray-core # don't forget restart the service.
```
