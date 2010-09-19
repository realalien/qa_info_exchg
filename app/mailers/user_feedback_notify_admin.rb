class UserFeedbackNotifyAdmin < ActionMailer::Base
  default :from => "from@example.com"
  
  
  def notification_email(advice)
      @advice = advice    # for page render
      subject = "Advice from #{@advice.name}"
      receiver = "zhujiacheng@spicyhorse.com"  # TODO: one-to-many relations, 
      mail(:subject => subject, :to =>  receiver )
  end
  
  
  
  
end
