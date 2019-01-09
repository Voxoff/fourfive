class DeletecartJob < ApplicationJob
  queue_as :default

  def perform
    puts "asdf"
    # carts = Cart.all.old
    # carts.destroy_all
  end
end
