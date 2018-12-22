module PunditControllable
  extend ActiveSupport::Concern
  def pundit_placeholder
    if current_or_guest_user == @cart.user
      return
    elsif params[:id]
      return if params[:id].to_i != @cart.id
    elsif params[:cart_id]
      return if params[:cart_id].to_i != @cart.id
    end

    flash[:notice] = "You do not have access to this page"
    return redirect_to root_path
  end
end
