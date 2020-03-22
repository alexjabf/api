# frozen_string_literal: true

# Serialisable Concern
module SerialisableResource
  def parse_json(object)
    ActiveModelSerializers::SerializableResource.new(object).as_json
  end
end
