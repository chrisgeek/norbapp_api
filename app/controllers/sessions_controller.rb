class SessionsController < Devise::SessionsController
  # skip_before_action :authenticate_user!
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    token_hash = {}
    token_hash['token'] = request.env['warden-jwt_auth.token']
    render json: {
      status: { code: 200, message: 'Logged in successfully.' },
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes].merge!(token_hash)
    }
  end

  def respond_to_on_destroy
    head :ok
  end
end
