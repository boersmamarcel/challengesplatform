class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :mailchimp


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :join_mailing_list, :role, :firstname, :lastname, :provider, :uid  

  
  has_many :followrelations, :class_name => 'Follow', :foreign_key => 'user_id', :dependent => :destroy
  has_many :follows, :through => :followrelations, :source => :follows
  has_many :inverse_followrelations, :class_name => 'Follow', :foreign_key => 'following_id', :dependent => :destroy
  has_many :followers, :through => :inverse_followrelations, :source => :user

  has_many :supervising_challenges, :foreign_key => 'supervisor_id', :class_name => 'Challenge'
  has_many :participating_challenges, :through => :enrollments, :source => :challenge
  has_many :enrollments, :foreign_key => 'participant_id', :dependent => :destroy

  before_save :default_values

  def is_supervisor?
    self.role > 0
  end

  def is_admin?
    self.role > 1
  end

  def default_values
      self.join_mailing_list = TRUE
      self.role = 0

      #roles
      # 0 = normal user
      # 1 = supervisor
      # 2 = admin

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
    	    		   :provider => access_token.provider,
                 :uid => access_token.uid,
    	    		  )

            user.add_to_mailchimp_list("Challenges")
        end
        user
    end
end
