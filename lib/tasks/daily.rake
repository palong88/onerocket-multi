# namespace :daily do
  desc "This task is called daily by the Heroku scheduler add-on"
  task :overdue_reminders => :environment do
    # puts 'OH MY GOD ITS FUCKING WORKING!'
    User.send_reminders
  end
# end
