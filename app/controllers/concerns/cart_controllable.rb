module CartControllable
	extend ActiveSupport::Concern

	# https://stackoverflow.com/questions/19230379/rails-how-should-i-share-logic-between-controllers
	# find or create cart for guest users 
	def get_cart
	  user = current_or_guest_user
	  @cart = Cart.find_by(user_id: current_or_guest_user.id, active: true)
	  if @cart.nil?
	    @cart = Cart.create(user_id: current_or_guest_user.id, active: true)
	  end
	  @cart
	end
end

