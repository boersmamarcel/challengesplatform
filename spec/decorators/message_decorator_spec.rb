require 'spec_helper'

describe SearchController do
  describe "Visibility of messages" do
    it "is visible if you received it" do
      @self       = FactoryGirl.create(:user, :role => 0, :active => true, :email => "self@example.com")
      @student1   = FactoryGirl.create(:user, :role => 0, :active => true, :email => "a@a.com", :firstname => "student user foo")
      @student2   = FactoryGirl.create(:user, :role => 0, :active => true, :email => "b@a.com", :firstname => "student user bar")
    
      @message1   = FactoryGirl.create(:message, :subject => "msg foo 1", :sender_id => @student1.id, :receiver_id => @self.id)
      @message2   = FactoryGirl.create(:message, :subject => "msg foo 2", :sender_id => @self.id, :receiver_id => @student1.id)
      @message3   = FactoryGirl.create(:message, :subject => "msg foo 3", :sender_id => @student1.id, :receiver_id => @student2.id)

      Message.visible_for_user(@self).should     include(@message1)
      Message.visible_for_user(@self).should_not include(@message2)
      Message.visible_for_user(@self).should_not include(@message3)
    end
  end
end