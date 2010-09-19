
require 'yaml'

config = YAML.load_file("d:/smtp_for_office.yaml")
smtp_user_domain = config["domain"]
smtp_user = config["user_name"]
smtp_password = config["password"]

# 
config.action_mailer.delivery_method = :smtp

config.action_mailer.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => smtp_user_domain,
  :user_name            => smtp_user,
  :password             => smtp_password,
  :authentication       => 'plain',
  :enable_starttls_auto => true  }