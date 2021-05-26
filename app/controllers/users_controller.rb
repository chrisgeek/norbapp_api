class UsersController < ApplicationController
  before_action :set_group, only: :index
  before_action :authenticate_user!
  def index
    render json: serialized_data(UserSerializer, @group.users)
  end

  def show
    user = User.find(params[:id])
    render json: serialized_data(UserSerializer, user)
  rescue ActiveRecord::RecordNotFound
    render json: 'Record Not Found', status: :unprocessable_entity
  end

  def signed_in_user
    render json: current_user
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
end
