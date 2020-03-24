#!/bin/bash

function log(){
    echo ''
    echo '-------------------------------------'
    echo "$*"
    echo '-------------------------------------'
    echo ''
}


function parser_v2ray_info(){
    while true
    do
        result=$(curl -s https://api.github.com/repos/v2ray/v2ray-core/releases/latest | jq "$1")
        if [ ! -z "$result" ]; then
            echo $result
            break
        fi
    done
}

log 'parser v2ray download url'

DOWNLOAD_URL=$( parser_v2ray_info '.assets[]|select(.name=="v2ray-macos.zip").browser_download_url' )

if [ -z "$DOWNLOAD_URL" ]; then
    
    log 'parser download url error, skip update.'
    exit 0
    
fi

log "download url: $DOWNLOAD_URL  start downloading..."

wget -q $DOWNLOAD_URL -O v2ray-macos.zip || { log 'file download failed!' ; exit 1; }

if [ ! -e v2ray-macos.zip ]; then
    log "file download failed!"
    exit 1
fi

V_HASH256=$(sha256sum v2ray-macos.zip |cut  -d ' ' -f 1)

log "file hash: $V_HASH256 parser v2ray-core version..."

V_VERSION=$( parser_v2ray_info '.tag_name' )
V_VERSION=$(echo ${V_VERSION:1})

if [ -z "$V_VERSION" ]; then
    
    log 'parser file version error, skip update.'
    exit 0
    
fi


log "file version: $V_VERSION start clone..."

git clone https://github.com/v2ray/homebrew-v2ray.git

log "update config...."

sed -i "s#^\s*url.*#  url \"$DOWNLOAD_URL\"#g" homebrew-v2ray/Formula/v2ray-core.rb
sed -i "s#^\s*sha256.*#  sha256 \"$V_HASH256\"#g" homebrew-v2ray/Formula/v2ray-core.rb
sed -i "s#^\s*version.*#  version \"$V_VERSION\"#g" homebrew-v2ray/Formula/v2ray-core.rb

log "update config done. start update repo..."

cd homebrew-v2ray
git commit -am "travis automated update version $V_VERSION"
git push  --quiet "https://${GH_TOKEN}@${GH_REF}" master:master

log "update repo done."
