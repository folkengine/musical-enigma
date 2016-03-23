require 'musical_enigma/sheen'
require_relative '../test_helper'

class TestSheen < Minitest::Test
  def test_sheen
    charlie = Sheen.new 'Charlie Sheen'
    charlie.set_status "winning!"
    assert_equal('Charlie Sheen is winning!', charlie.report)
    charlie.async.set_status "asynchronously winning!"
    assert_equal('Charlie Sheen is asynchronously winning!', charlie.report)
  end
end