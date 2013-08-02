class User < ActiveRecord::Base
  #roles
  # 0 = normal user
  # 1 = supervisor
  # 2 = admin

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :mailchimp

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :notify_by_email, :join_mailing_list, :firstname, :lastname, :tagline
  attr_protected :role, :provider, :uid, :active
  attr_readonly :email

  #Yeah, let's suppose admins are wise enough not to screw things up
  attr_accessible :email, :tagline, :remember_me, :notify_by_email, :join_mailing_list, :firstname, :lastname, :role, :active, as: :admin

  searchable do
    text :firstname, :boost => 5
    text :lastname, :boost => 2
    text :tagline

    string :type do
      "User"
    end
    boolean :active
  end

  validates :email, :presence => { :message => "is missing" }
  validates :firstname, :presence => { :message => "is missing"}
  validates :lastname, :presence => { :message => "is missing"}

  has_many :comments
  has_many :followrelations, :class_name => 'Follow', :foreign_key => 'user_id', :dependent => :destroy
  has_many :follows, :through => :followrelations, :source => :follows
  has_many :inverse_followrelations, :class_name => 'Follow', :foreign_key => 'following_id', :dependent => :destroy
  has_many :followers, :through => :inverse_followrelations, :source => :user
  has_many :supervising_challenges, :foreign_key => 'supervisor_id', :class_name => 'Challenge'
  has_many :participating_challenges, :source => :challenge, :through => :enrollments
  has_many :enrollments, :foreign_key => 'participant_id', :dependent => :destroy, :conditions => {:unenrolled_at => nil}
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_id'
  has_many :received_messages, :class_name => 'Message', :foreign_key => 'receiver_id'
  has_many :activities, :as => :event

  scope :active, where(:active => true)
  scope :search, lambda { |query|
    # TODO; more intelligent system
    query = query.split[0]
    where do
      (firstname =~ "%#{query}%") | (lastname =~ "%#{query}%")
    end  
  }

  def is_supervisor?
    self.role > 0
  end

  def is_admin?
    self.role > 1
  end

  def active_for_authentication?
    (super and self.active)
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
    # KEEP THIS CODE COMMENTED AND SAVED FOR FUTURE USE.
    # to_follower = followers.exists?(user)

    # my_challenges = participating_challenges
    # receiver_challenges = user.participating_challenges
    
    # Supervisors can send messages to participants and viceversa
    # supervisors = !(participating_challenges & user.supervising_challenges).empty?
    # supervising = !(supervising_challenges & user.participating_challenges).empty?
    
    # Users can send messages to co-participants of challenges
    # to_participants = !(my_challenges & receiver_challenges).empty?
    # ((to_follower || to_participants || supervisors || supervising) && id != user.id) || is_admin?
    
    true
  end

  def can_send_message_to_participants?(challenge)
    challenge.supervisor == self || is_admin?
  end

  # The code below takes over some newer Devise functionality
  # Originates from Devise recoverable.rb
  def ensure_reset_password_token!
    generate_reset_password_token! if should_generate_reset_token?
  end
    
  protected
    def should_generate_reset_token?
      reset_password_token.nil? || !reset_password_period_valid?
    end

    def generate_reset_password_token!
      self.reset_password_token = self.class.reset_password_token
      self.reset_password_sent_at = Time.now.utc
      self.reset_password_token
      save(:validate => false)
    end
end
