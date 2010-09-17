class ReminderMailer < ActionMailer::Base
  default :from => "no-reply@alienconsultants.com"
  
  
  def notification_email(email_addr , reminder)
        suject = reminder.title
        receiver = reminder.receiver  # TODO: one-to-many relations, 
        mail(:subject => subject, :to => receiver )
  end
end
