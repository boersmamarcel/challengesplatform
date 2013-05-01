require 'pp'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :mailchimp


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :join_mailing_list
  # attr_accessible :title, :body
  
  before_save :default_values

  def default_values
      self.join_mailing_list = TRUE
  end
  
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
        data = access_token.info
        user = User.where(:email => data["email"]).first

        unless user
            user = User.create(
    	    		   :email => data["email"],
    	    		   :password => Devise.friendly_token[0,20]
    	    		  )
    	    	  
            user.add_to_mailchimp_list("Challenges")
        end
        user
    end
end
