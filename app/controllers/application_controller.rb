class ApplicationController < ActionController::API
  # before_action :authenticate_user!

  def access_denied
    render json: 'Unauthorized Access'
  end

  def json_response(object, status = :ok)
    render json: object, status: status
  end

  # rescue_from CanCan::AccessDenied do |exception|
  #   render json: exception.message
  # end

  def serialized_data(serializer, data)
    serializer.new(data).serializable_hash.to_json
  end

  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ::NameError, with: :error_occurred
  rescue_from ::ActionController::RoutingError, with: :error_occurred
  rescue_from ::ActiveRecord::RecordInvalid, with: :record_not_found

  protected

  def record_not_found(exception)
    render json: { error: exception.message }.to_json, status: 404
  end

  def error_occurred(exception)
    render json: { error: exception.message }.to_json, status: 500
  end
end
