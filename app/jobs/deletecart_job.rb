class DeletecartJob < ApplicationJob
  queue_as :default

  def perform(destroy = false, count = 5)
    c = Cart.not_orders
            .includes(:address)
            .where(addresses: {id: nil})
            .where("carts.updated_at <= ?", Time.now - count.days)
    destroy ? c.destroy_all : c.count
  end
end
