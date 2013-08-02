require 'spec_helper'

describe SearchController, :search => true do
  before (:each) do

    Sunspot.remove_all!(User, Challenge, Message)
    Sunspot.commit
    Sunspot.index(User.all)
    Sunspot.index(Challenge.all)
    Sunspot.index(Message.all)
    Sunspot.commit

    @self   = FactoryGirl.create(:user, :role => 0, :active => true)

    @student1   = FactoryGirl.create(:user, :role => 0, :active => true, :email => "a@a.com", :firstname => "student user foo")
    @student2   = FactoryGirl.create(:user, :role => 0, :active => true, :email => "b@a.com", :firstname => "student user bar")
    @student3   = FactoryGirl.create(:user, :role => 0, :active => false, :email => "c@a.com", :firstname => "inactive user foo")
    @student4   = FactoryGirl.create(:user, :role => 0, :active => true, :email => "d@a.com", :firstname => "dummy")
    @supervisor = FactoryGirl.create(:user, :role => 1, :active => true, :email => "a@b.com", :firstname => "supervisor user foo")
    @admin      = FactoryGirl.create(:user, :role => 2, :active => true, :email => "a@c.com", :firstname => "admin user foo")
    @challenge1 = FactoryGirl.create(:challenge, :title => "Foo visible", :supervisor => @supervisor, :state => "approved")
    @challenge2 = FactoryGirl.create(:challenge, :title => "Foo hidden", :supervisor => @supervisor, :state => "pending")
    @message1   = FactoryGirl.create(:message, :subject => "msg foo 1", :sender_id => @self.id, :receiver_id => @student4.id)
    @message2   = FactoryGirl.create(:message, :subject => "msg foo 2", :sender_id => @student1.id, :receiver_id => @student4.id)
    @message3   = FactoryGirl.create(:message, :subject => "msg bar 1", :sender_id => @self.id, :receiver_id => @student4.id)
    @message4   = FactoryGirl.create(:message, :subject => "msg foo 3", :sender_id => @student4.id, :receiver_id => @self.id)
    
    Sunspot.commit

    sign_in @self
  end

  describe "does not allow outsiders to view pages" do
    it "returns http redirect for query" do
      sign_out @self
      get 'query'
      response.status.should eq(302)
    end
  end

  describe "Search functionality" do
    it "returns visible challenges matching the query" do
      get 'query', {:q => "Foo"}

      response.body.should include(@challenge1.decorate.title)
      response.body.should_not include(@challenge2.decorate.title)
    end

    it "returns users matching the query" do
      get 'query', {:q => "Foo"}

      response.body.should include(@student1.decorate.firstname)
      response.body.should_not include(@student2.decorate.firstname)
      response.body.should_not include(@student3.decorate.firstname)
      response.body.should include(@supervisor.decorate.firstname)
      response.body.should include(@admin.decorate.firstname)
    end

    it "returns visible messages matching the query" do
      get 'query', {:q => "Foo"}

      # You can't see this one, because sent messages can not be seen (yet)
      response.body.should_not include(@message1.decorate.subject)
      response.body.should_not include(@message2.decorate.subject)
      response.body.should_not include(@message3.decorate.subject)
      response.body.should include(@message4.decorate.subject)
    end
  end

  describe "Selective search" do
    it "allows selective searching for challenges" do
      get 'query', {:q => "Foo", :c => "c"}
      response.body.should include(@challenge1.decorate.title)
      response.body.should_not include(@student1.decorate.firstname)
      response.body.should_not include(@message1.decorate.subject)
    end

    it "allows selective searching for users" do
      get 'query', {:q => "Foo", :c => "u"}
      response.body.should include(@student1.decorate.firstname)
      response.body.should_not include(@challenge1.decorate.title)
      response.body.should_not include(@message1.decorate.subject)
    end

    it "allows selective searching for messages" do
      get 'query', {:q => "Foo", :c => "m"}

      response.body.should include(@message4.decorate.subject)
      response.body.should_not include(@student1.decorate.firstname)
      response.body.should_not include(@challenge1.decorate.title)
    end

    it "allows full search" do
      get 'query', {:q => "Foo"}
      response.body.should include(@challenge1.decorate.title)
      response.body.should include(@student1.decorate.firstname)
      response.body.should include(@message4.decorate.subject)
    end
  end
end