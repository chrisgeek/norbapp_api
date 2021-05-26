class UpgradeSubscriptionService
  def initialize(payment_ref)
    @payment_ref = payment_ref
  end

  def upgrade
    payment_service = PaymentService.new
    data = payment_service.verify_payment(@payment_ref)
    group = Group.find(data['data']['metadata']['group_id'])
    case group.subscription.subscription_list.name
    when 'Free'
      group.subscription.update(subscription_list_id: premium_subscription_id, payment_ref: @payment_ref)
    when 'premium'
      renew_subscription(group)
    end
  end

  private

  def renew_subscription(group)
    group.subscription.update(renewed_at: DateTime.now, payment_ref: @payment_ref)
  end

  def premium_subscription_id
    SubscriptionList.where(name: 'premium').first.id
  end
end
