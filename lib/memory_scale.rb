class MemoryScale

  def initialize
    tare
  end

  def tare
    GC.start
    @objects = {}
    each_object do |object, id|
      (@objects[object.class] ||= []) << id
    end
    @objects
  end

  def weigh
    GC.start
    objects = {}
    each_object do |object, id|
      instances = @objects[object.class]
      if instances.try(:include?, id)
        (objects[object.class] ||= []) << id
      end
    end
    objects
  end

  
  private

  def each_object
    ObjectSpace.each_object(ActiveRecord::Base) do |object|
      id = object.repond_to?(:id) ? object.id : object.object_id
      yield object, id
    end
  end

end
