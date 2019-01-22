desc "This task is called by the Heroku scheduler add-on"
task delete_old_data: :environment do
  puts "Deleting old Users..."
  DeleteOldUsersJob.perform_now(true, 7)
  puts "Deleting Carts with no users..."
  DeletecartJob.perform_now(true, 7)
  puts "Done."
end

task count_old_data: :environment do
  puts DeleteOldUsersJob.perform_now(false, 5)
  puts DeletecartJob.perform_now(false, 5)
  puts "Done."
end
