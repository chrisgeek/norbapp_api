class PendingRequestsController < ApplicationController
  before_action :set_group, only: :index
  before_action :set_pending_request, only: %i[approve_request deny_request]
  def index
    pending_requests = @group.pending_requests
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
    user = User.find(@pr.user_id)
    group = Group.find(@pr.group_id)
    if user.groups << group
      @pr.destroy
    end
    render json: 'Request Approved'
  end

  def deny_request
    @pr.delete!
    render json: 'Request Denied'
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_pending_request
    @pr = PendingRequest.find(params[:pending_request_id])
  end

  def pending_request_params
    params.require(:pending_request).permit(:user_id, :group_id)
  end
end
