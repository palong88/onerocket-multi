namespace :daily do
  desc "This task is called daily by the Heroku scheduler add-on"
  task :overdue_reminders => :environment do
    Apartment.tenant_names.uniq.each do |tenant|
      Apartment::Tenant.switch(tenant)
      User.all.each do |u|
        u.send_reminder
      end
    end
  end
end
