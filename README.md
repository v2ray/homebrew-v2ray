### homebrew v2ray


The homebrew tap for v2ray-core.



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

### Usage

once you installed, you can run command via `v2ray` to run v2ray-core.

The defualt config file location is:`/usr/local/etc/config.json`

step 1: edit the default config:

```bash
vim /usr/local/etc/config.json
```

step 2: run v2ray-core without starting at login.

```bash
brew services run v2ray-core
```

or run v2ray-core and register it to launch at login via:

```bash
brew services start v2ray-core
```




