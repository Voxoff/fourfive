module PunditControllable
  extend ActiveSupport::Concern
  def pundit_placeholder
    if params[:id] && params[:controller] == "carts" && params[:id].to_i != @cart&.id
      flashit
      return redirect_to root_path
    elsif current_or_guest_user != @cart.user
      flashit
      return redirect_to root_path
    elsif params[:cart_id] && params[:cart_id].to_i != @cart.id
      flashit
      return redirect_to root_path
    end
  end

  def flashit
    flash[:notice] = "You do not have access to this page"
  end
end
