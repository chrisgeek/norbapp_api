class PaymentService
  def initialize(email = nil, group_id = nil)
    @email = email
    @group_id = group_id
    @paystack = Paystack.new(Rails.application.credentials.dig(:paystack, :paystack_public_key),
                             Rails.application.credentials.dig(:paystack, :paystack_private_key))
  end

  def make_payment
    transactions = PaystackTransactions.new(@paystack)
    result = transactions.initializeTransaction(
      amount: SubscriptionList.where(name: 'premium').first.price.to_i,
      email: @email,
      metadata: { group_id: @group_id },
      message: @group_id
    )
    # binding.pry
    # result = PaystackTransactions.initializeTransaction(@paystack, { amount: @amount, email: @email, group_id: @group_id })
    result['data']['authorization_url']
  end

  def verify_payment(ref)
    transaction = PaystackTransactions.new(@paystack)
    transaction.verify(ref)
  end
end
