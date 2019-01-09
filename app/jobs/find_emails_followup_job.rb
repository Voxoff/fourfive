class FindEmailsFollowupJob < ApplicationJob
  queue_as :default

  def perform(*args)
    followup_emails = Cart.where(active: true).joins(:address).merge(Address.where.not(email: nil)).pluck(:'addresses.email')
    order_emails = Cart.orders.joins(:address).pluck(:'addresses.email')
    return followup_emails - order_emails
  end
end
