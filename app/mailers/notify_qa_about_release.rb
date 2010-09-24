class NotifyQaAboutRelease < ActionMailer::Base
  default :from => "admin@spicyhorse.com"
  
  def send_release_notification(release_packages, mail_title, rec)
      @pkgs = release_packages    # for page render
      subject = mail_title || "Today's release(s) are ready. "
      receiver = rec || "zhujiacheng@spicyhorse.com"  # TODO: one-to-many relations, 
      
      mail(:subject => subject, :to =>  receiver )
  end
end
