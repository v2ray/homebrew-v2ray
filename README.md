#### homebrew v2ray


The homebrew tap for v2ray-core.


#### Usage


Install v2ray-core via homebrew

step 1: Add tap

```bash
brew tap doublemine/v2ray
```

step 2: Install v2ray:

```bash
brew install v2ray-core
```

once you installed, you can run command via `v2ray` to run v2ray-core.

The defualt config file location is:`/usr/local/etc/config.json`

step 3: edit the default config:

```bash
vim /usr/local/etc/config.json
```

step 4: run v2ray

```bash
brew services run v2ray-core
```