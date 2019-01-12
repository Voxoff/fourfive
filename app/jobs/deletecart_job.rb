class DeletecartJob < ApplicationJob
  queue_as :default

  def perform(destroy = false)
    c = Cart.not_orders
            .includes(:address)
            .where(addresses: {id: nil})
            .where("carts.updated_at <= ?", Time.now - 5.days)
    c.destroy_all if destroy
  end
end
