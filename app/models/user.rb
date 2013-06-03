class User < ActiveRecord::Base
  #roles
  # 0 = normal user
  # 1 = supervisor
  # 2 = admin

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :mailchimp

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :join_mailing_list, :firstname, :lastname
  attr_protected :role, :provider, :uid

  has_many :comments
  has_many :followrelations, :class_name => 'Follow', :foreign_key => 'user_id', :dependent => :destroy
  has_many :follows, :through => :followrelations, :source => :follows
  has_many :inverse_followrelations, :class_name => 'Follow', :foreign_key => 'following_id', :dependent => :destroy
  has_many :followers, :through => :inverse_followrelations, :source => :user
  has_many :supervising_challenges, :foreign_key => 'supervisor_id', :class_name => 'Challenge'
  has_many :participating_challenges, :through => :enrollments, :source => :challenge
  has_many :enrollments, :foreign_key => 'participant_id', :dependent => :destroy
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_id'
  has_many :received_messages, :class_name => 'Message', :foreign_key => 'receiver_id'

  def is_supervisor?
    self.role > 0
  end

  def is_admin?
    self.role > 1
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first
    unless user
      user = User.create(
        :firstname => data["first_name"],
        :lastname => data["last_name"],
        :email => data["email"],
        :password => Devise.friendly_token[0,20],
      )
      user.provider = access_token.provider
      user.uid = access_token.uid
      user.save
      user.add_to_mailchimp_list("Challenges")
    end
    user
  end

  def can_send_message_to_user?(user)
    to_follower = followers.exists?(user)

    my_challenges = participating_challenges
    receiver_challenges = user.participating_challenges
    to_participants = !(my_challenges & receiver_challenges).empty?

    (to_follower || to_participants) && id != user.id
  end

  def can_send_message_to_participants?(challenge)
    challenge.supervisor == self
  end

end
