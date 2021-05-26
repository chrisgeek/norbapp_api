class GroupsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    groups = Group.all
    render json: serialized_data(GroupSerializer, groups)
  end

  def create
    @group = current_user.groups.create!(group_params)
    if @group.save
      current_user.add_role :admin, @group
      render json: 'Group Created Successfully', status: :created
    else
      render json: @group.errors
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :admin_id)
  end
end
