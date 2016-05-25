
#Uses Gmail local and Sendgrid on production
if Rails.env.development?
	ActionMailer::Base.delivery_method = :smtp
	ActionMailer::Base.smtp_settings = {
	  address:              'smtp.gmail.com',
	  port:                 587,
	  domain:               'ancient-bastion-57550.herokuapp.com',
	  user_name:            'patrick@olearylong.com',
	  password:             'pa_thax_54T',
	  authentication:       'plain',
	  enable_starttls_auto: true  }

elsif Rails.env.production?

  ActionMailer::Base.delivery_method = :smtp
	ActionMailer::Base.smtp_settings = {
	  address:              'smtp.sendgrid.net',
	  port:                 587,
	  domain:               'heroku.com',
	  user_name:            ENV["SENDGRID_USERNAME"],
	  password:             ENV["SENDGRID_PASSWORD"],
	  authentication:       'plain',
	  enable_starttls_auto: true  }
end





