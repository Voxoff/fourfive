class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        logging_in
        # reload guest_user to prevent caching problems before destruction
        guest_user(with_retry = false).try(:reload).try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session, creating one as needed
  def guest_user(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)
    rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
    session[:guest_user_id] = nil
    guest_user if with_retry
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  private

  # called when the user logs in, hand off from guest_user to current_user.
  def logging_in
    cart = guest_user.cart
    current_user.cart = cart
  end

  def create_guest_user
    u = User.new(guest: true, email: "guest_#{Time.now.to_i}#{rand(1000)}@example.com")
    u.save!(validate: false)
    session[:guest_user_id] = u.id
    u
  end
end
