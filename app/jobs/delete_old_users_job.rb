class DeleteOldUsersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    #get all users that do not have a cart and have not been updated for a week
    users = User.left_outer_joins(:carts)
                .where(carts: { user_id: nil })
                .where("users.updated_at <= ?", Time.now - 7.days)
  end
end
