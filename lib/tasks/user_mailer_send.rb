module UserMailerSend
  extend ActiveSupport::Concern

  included do
    after_save :do_something
  end

  def do_something
  	UserMailer.registration_confirmation(@user).deliver
  end
end