require_relative '../spec_helper'

describe ChallengesController do
	include Devise::TestHelpers

	before (:each) do
		@user = FactoryGirl.create(:user, :role => 1)
		@user2 = FactoryGirl.create(:user, :firstname => "John", :lastname => "Ivy", :email => "j.i@student.utwente.nl")
		@challenge = FactoryGirl.create(:challenge, :title => "Hello!", :supervisor_id => @user.id)
		sign_in @user
	end

	it "should say something went wrong when revoking a challenge" do
		Challenge.any_instance.stub(:save).and_return(false)
		get :revoke, :id => @challenge.id
		flash[:alert].should include("Couldn't revoke challenge")
	end
	
	it "should deny supervisors from participating in their own challenges" do
	  get :enroll, :id => @challenge.id
	  flash[:alert].should include("You cannot be a participant")
  end

end