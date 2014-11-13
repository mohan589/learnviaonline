ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,  
  :user_name            => "learnviaonline@gmail.com",
  :password             => "mohan143",
  :authentication       => "login",
  :enable_starttls_auto => true
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default characterset: "utf-8"