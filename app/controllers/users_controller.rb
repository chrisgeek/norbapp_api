class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    render json: serialized_data(UserSerializer, User.all)
  end

  def signed_in_user
    render json: current_user
  end
end
