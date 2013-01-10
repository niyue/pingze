require "minitest/autorun"
require "pingze"

class TestPingze < MiniTest::Unit::TestCase
  def test_pingze
    pingze = Pingze.new
    ze_ping = pingze.gen
    assert ze_ping.length > 0
    puts ze_ping
  end
end
