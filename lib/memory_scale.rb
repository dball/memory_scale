class MemoryScale

  def initialize
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
      if contains_object?(@objects, object)
        store_object(objects, object)
      end
    end
    objects
  end

  
  private

  def each_object
    ObjectSpace.each_object(ActiveRecord::Base) do |object|
      yield object
    end
  end

  def store_object(container, object)
    (container[object.class] ||= []) << get_object_id(object)
  end

  def contains_object?(container, object)
    container[object.class].try(:include?, get_object_id(object))
  end

  def get_object_id(object)
    object.respond_to?(:id) ? object.id : object.object_id
  end

end
