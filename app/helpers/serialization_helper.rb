module SerializationHelper
  def serialize_resource(resource, serializer)
    ActiveModelSerializers::SerializableResource.new(resource, each_serializer: serializer).as_json
  end
end
