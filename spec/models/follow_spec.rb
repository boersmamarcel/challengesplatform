require_relative '../spec_helper'

describe Follow do
  
  it "should delete all follow relations if an user deletes there account" do
    user_one = User.create(
      :email => 'user1@student.utwente.nl', 
      :password => 'blaat123456', 
      :password_confirmation => 'blaat123456',
      :firstname => "John",
      :lastname => "Doe"
    )
    user_two = User.create(
      :email => 'user2@student.utwente.nl', 
      :password => 'blaat123456', 
      :password_confirmation => 'blaat123456',
      :firstname => "Jane",
      :lastname => "Doe"
    )
    
    follow = Follow.create(:user_id => user_one.id, :following_id => user_two.id)
    
    user_one_id = user_one.id
    if user_one.destroy
      f = Follow.where(:user_id => user_one_id)
      f.count.should be_zero
    end
  end
  
  it "should delete all following relations if an user deletes there account" do
     user_one = User.create(
      :email => 'user1@student.utwente.nl', 
      :password => 'blaat123456', 
      :password_confirmation => 'blaat123456',
      :firstname => "John",
      :lastname => "Doe"
    )
    user_two = User.create(
      :email => 'user2@student.utwente.nl', 
      :password => 'blaat123456', 
      :password_confirmation => 'blaat123456',
      :firstname => "Jane",
      :lastname => "Doe"
    )

    #user two follows user one
    follow = Follow.create(:user_id => user_two.id, :following_id => user_one.id)
     
    user_one_id = user_one.id
     
    #user one is deleted
    if user_one.destroy
      #there should be no records of any user following user one
      f = Follow.where(:following_id => user_one_id)
      f.count.should be_zero
    end
  end
end