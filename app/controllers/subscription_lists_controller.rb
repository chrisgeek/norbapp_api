class SubscriptionListsController < ApplicationController
  before_action :set_subscription_list, only: %i[update destroy show]
  before_action :authenticate_user!
  def index
    subscription_lists = SubscriptionList.all
    render json: serialized_data(SubscriptionListSerializer, subscription_lists)
  end

  def create
    subscription_list = SubscriptionList.create!(subscription_list_params)
    if subscription_list.save
      render json: serialized_data(SubscriptionListSerializer, subscription_list)
    else
      render json: subscription_list.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @subscription_list
  end

  def update
    if @subscription_list.update!(subscription_list_params)
      render json: 'Updated Successfully'
    else
      render json: @subscription_list.errors
    end
  end

  def destroy
    @subscription_list.destroy!
    render json: 'Destroyed Successfully'
  end

  private

  def subscription_list_params
    params.require(:subscription_list).permit(:name, :price, :user_limit)
  end

  def set_subscription_list
    @subscription_list = SubscriptionList.find(params[:id])
  end
end
