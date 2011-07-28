require 'test_helper'

class MemoryScaleTest < Test::Unit::TestCase

  def test_empty_initialize
    ObjectSpace.expects(:each_object).with(Object)
    scale = MemoryScale.new
    assert_equal({}, scale.objects)
  end

  def test_initialize_with_string
    ObjectSpace.expects(:each_object).with(String).
      multiple_yields(*((1..3).map { |i| mock_object(String, i) }))
    scale = MemoryScale.new(String)
    assert_equal({ String => [1, 2, 3] }, scale.objects)
  end

  def test_tare
    ObjectSpace.expects(:each_object).with(String)
    scale = MemoryScale.new(String)
    ObjectSpace.expects(:each_object).with(String).
      multiple_yields(*((1..3).map { |i| mock_object(String, i) }))
    scale.tare
    assert_equal({ String => [1, 2, 3] }, scale.objects)
  end

  def test_weigh
    ObjectSpace.expects(:each_object).with(String).
      multiple_yields(*((1..3).map { |i| mock_object(String, i) }))
    scale = MemoryScale.new(String)
    ObjectSpace.expects(:each_object).with(String).
      multiple_yields(*((3..5).map { |i| mock_object(String, i) }))
    weight = scale.weigh
    assert_equal({ String => [4, 5] }, weight)
  end


  private

  def mock_object(klass, id)
    object = mock()
    object.stubs(:class).returns(klass)
    object.stubs(:object_id).returns(id)
    object
  end

end
