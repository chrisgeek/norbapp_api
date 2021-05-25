class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[show update destroy]
  before_action :set_group

  def index
    subscription = Subscription.all
    render json: subscription
  end

  def create
    if @group.create_subscription(subscription_params)
      render json: 'Subscription Created Successfully', status: :created
    else
      render json: @group.errors
    end
  end

  def show
    render json: @subscription
  end

  def destroy
    @subscription.destroy!
    render json: 'Deleted Successfully'
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def subscription_params
    params.require(:subscription).permit(:group_id, :subscription_list_id)
  end
end
