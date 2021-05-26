class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[show update destroy]
  before_action :set_group, only: %i[make_payment]
  before_action :authenticate_user!, except: [:confirm_payment]

  def index
    subscription = Subscription.all
    serialized_data(SubscriptionSerializer, subscription)
  end

  def create
    if @group.create_subscription(subscription_params)
      render json: 'Subscription Created Successfully', status: :created
    else
      render json: @group.errors
    end
  end

  def make_payment
    # binding.pry
    payment_service = PaymentService.new(params[:email], params[:group_id])
    data = payment_service.make_payment
    render json: data
  end

  def confirm_payment
    UpgradeSubscriptionService.new(params[:reference]).upgrade
    render json: 'Premium subscription activated successfully'.to_json
  end

  def show
    render json: @subscription
    serialized_data(SubscriptionSerializer, @subscription)
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
    @group_id = @group
  end

  def subscription_params
    params.require(:subscription).permit(:group_id, :subscription_list_id)
  end
end
