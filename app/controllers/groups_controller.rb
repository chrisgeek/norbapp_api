class GroupsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    groups = Group.all
    json_response(serialized_data(GroupSerializer, groups))
  end

  def create
    @group = current_user.groups.create!(group_params)
    if @group.save
      current_user.add_role :admin, @group
      json_response(serialized_data(GroupSerializer, @group))
    else
      render json: @group.errors
    end
  end

  def update
    @group.update(group_params)
    render json: 'Successfully updated group'
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :admin_id)
  end
end
