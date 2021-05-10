class ApplicationController < ActionController::API
  def serialized_data(serializer, data)
    serializer.new(data).serializable_hash.to_json
  end
end
