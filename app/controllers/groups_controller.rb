class GroupsController < ApplicationController
  def index
    render json: Group.all
  end

  def create
    binding.pry
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
