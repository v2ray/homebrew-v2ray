# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class V2rayCore < Formula
  desc "A platform for building proxies to bypass network restrictions."
  homepage "https://www.v2ray.com/"
  url "https://github.com/v2ray/v2ray-core/releases/download/v2.45/v2ray-macos.zip"
  version "2.45"
  sha256 "02d4ac546830485fad2b925d2ca8d652fd25c057f8d7a520842d62ac2176fcfb"

  # depends_on "cmake" => :build

  def install

    bin.install "v2ray"

    etc.install "config.json"

  end

  plist_options :manual => "v2ray -config=#{HOMEBREW_PREFIX}/etc/config.json"

  def plist; <<-EOS.undent
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <true/>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{bin}/v2ray</string>
        <string>-config</string>
        <string>#{etc}/config.json</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
    </dict>
  </plist>
  EOS
  end




  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test v2ray-core`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/v2ray", "-version"
  end
end
