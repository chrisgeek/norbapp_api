class PendingRequestsController < ApplicationController
  before_action :set_group, only: :index
  before_action :set_pending_request, only: %i[approve_request deny_request]
  def index
    pending_requests = @group.pending_requests.pending
    render json: pending_requests
  end

  def create
    pending_request = PendingRequest.create!(pending_request_params)
    if pending_request.save
      render json: 'Request sent successfully'
    else
      render json: pending_request.errors
    end
  end

  def approve_request
    user = User.find(@pending_request.user_id)
    group = Group.find(@pending_request.group_id)
    # if group.subscription_list.name == 'Free' && group.users.count == 10
    #   render json: 'Upgrade to the premium plan to add more members'
    # else
    group.users << user
    @pending_request.update(status: 'approved')
    render json: "User added to #{group.name} group"
    # end
  end

  def deny_request
    @pending_request.update(status: 'declined')
    render json: 'Request Denied'
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_pending_request
    @pending_request = PendingRequest.find(params[:pending_request_id])
  end

  def pending_request_params
    params.require(:pending_request).permit(:user_id, :group_id)
  end
end
