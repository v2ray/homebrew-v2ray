class V2rayCore < Formula
  desc "A platform for building proxies to bypass network restrictions."
  homepage "https://www.v2fly.org/"
  url "https://github.com/v2fly/v2ray-core/releases/download/v4.32.1/v2ray-macos-64.zip"
  sha256 "8fabf66de1cb15817ee0650f345f67bcecd82c32c587e5e5e0c82a7943a10e76"
  license "MIT"

  def install
    bin.install "v2ray"
    bin.install "v2ctl"
    (etc/"v2ray").install "config.json"
    (etc/"v2ray").install "geoip.dat"
    (etc/"v2ray").install "geosite.dat"
  end

  plist_options :manual => "v2ray -config=#{HOMEBREW_PREFIX}/etc/v2ray/config.json"

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
    config = "{\"log\":{\"access\":\"#{testpath}/log\"}}"
    output = shell_output "echo '#{config}' | #{bin}/v2ray -test"
    assert_match "Configuration OK", output
    assert_predicate testpath/"log", :exist?
  end
end
