class UserMailer < ActionMailer::Base
  default from: "learnviaonline@gmail.com"
  def registration_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "Registered")
  end

  def account_activation(user)
    @user = user
    mail(:to => user.email, :subject => "Registered")
  end


  def password_reset
	@greeting = "Hi"

    mail to: "to@example.org"
  end
end
