require 'test_helper'

class MemoryScaleTest < Test::Unit::TestCase

  def test_initialize
    assert MemoryScale.new(Object)
  end

end
