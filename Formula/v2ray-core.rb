class V2rayCore < Formula
  desc "Platform for building proxies to bypass network restrictions"
  homepage "https://www.v2fly.org/"
  url "https://github.com/v2fly/v2ray-core/releases/download/v4.33.0/v2ray-macos-64.zip"
  version "4.33.0"
  sha256 "4508619bba84e0b6719b7b66a5421a0590c5b5bb8f29b6bfd7392a30610d5127"
  license all_of: ["MIT", "CC-BY-SA-4.0"]

  def install
    bin.install "v2ray"
    bin.install "v2ctl"

    pkgetc.install "config.json"

    pkgshare.install "geoip.dat"
    pkgshare.install "geosite.dat"
  end

  plist_options manual: "v2ray -config=#{HOMEBREW_PREFIX}/etc/v2ray/config.json"

  def plist; <<~EOS
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <true/>
      <key>RunAtLoad</key>
      <true/>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{bin}/v2ray</string>
        <string>-config</string>
        <string>#{etc}/v2ray/config.json</string>
      </array>
    </dict>
  </plist>
  EOS
  end

  test do
    (testpath/"config.json").write <<~EOS
      {
        "log": {
          "access": "#{testpath}/log"
        },
        "outbounds": [
          {
            "protocol": "freedom",
            "tag": "direct"
          }
        ],
        "routing": {
          "rules": [
            {
              "ip": [
                "geoip:private"
              ],
              "outboundTag": "direct",
              "type": "field"
            }
          ]
        }
      }
    EOS
    output = shell_output "#{bin}/v2ray -c #{testpath}/config.json -test"

    assert_match "Configuration OK", output
    assert_predicate testpath/"log", :exist?
  end
  
  def caveats
    <<~EOS
      v2ray-core has entered homebrew-core (https://github.com/Homebrew/homebrew-core).
      We suggest most users installing it with `brew install v2ray`.
      However, you can continue using this formula.
    EOS
  end
end
