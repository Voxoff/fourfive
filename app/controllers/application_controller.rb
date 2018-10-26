class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!

  # # if user is logged in, return current_user, else return guest_user
  # def current_or_guest_user
  #   if current_user
  #     if session[:guest_user_id] && session[:guest_user_id] != current_user.id
  #       logging_in
  #       # reload guest_user to prevent caching problems before destruction
  #       guest_user(with_retry = false).try(:reload).try(:destroy)
  #       session[:guest_user_id] = nil
  #     end
  #     current_user
  #   else
  #     guest_user
  #   end
  # end

  # # find guest_user object associated with the current session,
  # # creating one as needed
  # def guest_user(with_retry = true)
  #   # Cache the value the first time it's gotten.
  #   @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  # rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
  #    session[:guest_user_id] = nil
  #    guest_user if with_retry
  # end

  # private

  # # called (once) when the user logs in, insert any code your application needs
  # # to hand off from guest_user to current_user.
  # def logging_in
  #   # For example:
  #   # guest_comments = guest_user.comments.all
  #   # guest_comments.each do |comment|
  #     # comment.user_id = current_user.id
  #     # comment.save!
  #   # end
  # end

  # def create_guest_user
  #   user = User.new(:name => "guest", :email => "guest_#{Time.now.to_i}#{rand(100)}@example.com")
  #   user.save!(:validate => false)
  #   session[:guest_user_id] = user.id
  #   user
  # end
  
  # def self.find_cart
  #   # current_user = env['warden'].current_user
  #   if current_user
  #     @cart = Cart.find_by(user_id: current_user.id, active: true)
  #   else
  #     @cart = Cart.find(session[:cart_id])
  #   end
  #   create_cart unless @cart
  #   @cart
  # end

  # def create_cart
  #   current_user = env['warden'].current_user
  #   if current_user
  #     @cart = Cart.create(user_id: current_user.id)
  #   else
  #     @cart = Cart.create
  #     session[:cart_id] = @cart.id
  #   end
  #   @cart
  # end
  # # binding.pry
  # @cart = self.find_cart


end
