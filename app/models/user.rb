class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # include UserMailerSend
  mount_uploader :image, ImageUploader
  # extend FriendlyId
  # friendly_id :user_name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :user_groups
  has_many :groups, :through => :user_groups
  has_many :questions
  has_many :answers

  before_create :assign_default_group
  before_save   :downcase_email
  before_create :create_activation_digest

  after_create :send_mail

  def send_mail
    UserMailer.registration_confirmation(self).deliver    
  end

  def activated?
    activated
  end

  def activated!
    self.activated = true
    save
  end

  # Other model stuff here

  private

  def assign_default_group
    # This automatically creates the UserGroup record    

    # self.groups << Group.find_by_name(self)
  end

  def create_activation_digest
    # Create the token and digest.
    self.activation_digest = SecureRandom.hex
  end

  def downcase_email
      self.email = email.downcase
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
end
