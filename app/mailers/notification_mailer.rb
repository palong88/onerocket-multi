class NotificationMailer < ApplicationMailer
  default from: 'noreply@onerocket.io'

  def overdue_email(user)
    @user = user
    @url  = 'https://' + @user.subdomain + ".onerocket.io/eadmin_tasks"
    mail(to: @user.email, subject: 'You have one or more overdue tasks!')
  end

  def tattle_tale(user, employee)
    @user = user
    @employee = employee
    @url  = 'https://' + @user.subdomain + ".onerocket.io/users"
    mail(to: user.email, subject: @employee.name + " is overdue on one or more tasks")
  end
end
