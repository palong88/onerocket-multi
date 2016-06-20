class NotificationMailer < ApplicationMailer
  default from: 'noreply@onerocket.io'

  def overdue_email(user)
    @user = user
    @url  = 'https://' + @user.subdomain + ".onerocket.io/eadmin_tasks"
    mail(to: @user.email, subject: 'You have one or more overdue tasks!')
  end
end
