class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :configure_permitted_parameters, except: :create

  def create
    build_resource(sign_up_params)
    if resource.save
      render json: resource,
             serializer: UserSerializer,
             meta: { message: 'Sign up success', token: request.headers['Authorization'] },
             status: :created
    else
      render json: resource.errors
    end
  end

  protected

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :phone, :email, :password, :address,
                                 :password_confirmation, :dob, :gender, :bio, :status)
  end

  def respond_with(resource, _opts = {})
    render json: UserSerializer.new(resource).serializable_hash.to_json
  end

  def respond_to_on_destroy
    head :no_content
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name phone email
                                                                dob status gender bio status])
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name phone email password password_confirmation
                                                         gender status bio])
  end
end
