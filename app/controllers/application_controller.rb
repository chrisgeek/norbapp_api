class ApplicationController < ActionController::API
  # rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found(exception)
    render json: { error: exception.message }.to_json, status: 404
  end

  def serialized_data(serializer, data)
    serializer.new(data).serializable_hash.to_json
  end
end
