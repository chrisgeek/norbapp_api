class GroupsController < ApplicationController
  def index
    groups = Group.all
    render json: serialized_data(GroupSerializer, groups)
  end

  def create
    @group = current_user.groups.create!(group_params)
    if @group.save
      current_user.update_attribute(:role, 'admin') # set first user as admin
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
