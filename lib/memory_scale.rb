class MemoryScale

  attr_reader :objects

  def initialize(match = Object)
    @match = match
    tare
  end

  def tare
    GC.start
    @objects = {}
    each_object do |object|
      store_object(@objects, object)
    end
    @objects
  end

  def weigh
    GC.start
    objects = {}
    each_object do |object|
      unless contains_object?(@objects, object)
        store_object(objects, object)
      end
    end
    objects
  end

  
  private

  def each_object
    ObjectSpace.each_object(@match) do |object|
      yield object
    end
  end

  def store_object(container, object)
    (container[object.class] ||= []) << get_object_id(object)
  end

  def contains_object?(container, object)
    class_container = container[object.class]
    class_container.include?(get_object_id(object)) if class_container
  end

  def get_object_id(object)
    object.respond_to?(:id) ? object.id : object.object_id
  end

end
