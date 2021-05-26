class ApplicationController < ActionController::API
  # rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  # before_action :authenticate_user!
  def record_not_found(exception)
    render json: { error: exception.message }.to_json, status: 404
  end

  def access_denied
    render json: 'Unauthorized Access'
  end

  # rescue_from CanCan::AccessDenied do |exception|
  #   render json: exception.message
  # end

  def serialized_data(serializer, data)
    serializer.new(data).serializable_hash.to_json
  end
end
